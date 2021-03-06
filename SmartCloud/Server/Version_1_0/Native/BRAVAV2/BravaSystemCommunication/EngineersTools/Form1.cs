﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Xml;
using BravaSystem.Communication;

namespace EngineersTools
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        #region Configuration and Initialisation
        SiteConfigurationData SiteConfig = new SiteConfigurationData();

        private void Form1_Load(object sender, EventArgs e)
        {
            this.ReadSettings();
            this.PopulateFormFromXML();

        }

        /// <summary>
        /// Load XML configuration files into memory.
        /// </summary>
        private void ReadSettings()
        {
            if ("file" == EngineersTools.Properties.Settings.Default.SiteConfigurationXMLSource)
            {
                string xmlFileNameSiteConfig = EngineersTools.Properties.Settings.Default.SiteConfigurationXMLFile;

                if (System.IO.File.Exists(xmlFileNameSiteConfig))
                {
                    this.txtConfigXMLFileName.Text = xmlFileNameSiteConfig;
                    SiteConfig.SiteConfigurationXML = new XmlDocument();
                    SiteConfig.SiteConfigurationXML.Load(xmlFileNameSiteConfig);
                }

                string xmlFileNameDevices = EngineersTools.Properties.Settings.Default.DeviceTypesXMLFile;

                if (System.IO.File.Exists(xmlFileNameDevices))
                {
                    SiteConfig.DeviceTypesXML = new XmlDocument();
                    SiteConfig.DeviceTypesXML.Load(xmlFileNameDevices);
                }

                string xmlFileNameUnitDetails = EngineersTools.Properties.Settings.Default.UnitDetailsXMLFile;

                if (System.IO.File.Exists(xmlFileNameUnitDetails))
                {
                    SiteConfig.UnitDetailsXML = new XmlDocument();
                    SiteConfig.UnitDetailsXML.Load(xmlFileNameUnitDetails);
                }
            }
        }

        /// <summary>
        /// Update Form labels and field values from configuration XML.
        /// </summary>
        private void PopulateFormFromXML()
        {
            if (SiteConfig.DeviceTypesXML != null)
            {
                // Populate the TableHeaders.
                XmlNodeList SwitchBankNodes = SiteConfig.DeviceTypesXML.SelectNodes("//*[@SwitchBankType='RESIDENT_8SW']/Switch[@UserName != 'unused']");
                foreach (XmlNode switchNode in SwitchBankNodes)
                {
                    // Populate DataGrid headers
                    // int bankIndexVal = int.Parse(switchNode.Attributes["BankIndex"].InnerText);
                    string bankIndexStr = switchNode.Attributes["BankIndex"].InnerText;

                    dataGridView1.Columns["switchstate" + bankIndexStr + "DataGridViewCheckBoxColumn"].HeaderText = switchNode.Attributes["UserName"].InnerText;
                    //dsLiveSiteData.dtSiteDataStatusView.Columns["switchstate" + bankIndexStr].Caption = switchNode.Attributes["UserName"].InnerText;

                    gbLS8Control.Controls["cbSingleSw" + bankIndexStr].Text = switchNode.Attributes["UserName"].InnerText;
                }
            }

            if (SiteConfig.SiteConfigurationXML != null)
            {
                // First we blank out any existing data.
                cmbListOfIPAddress.Items.Clear();
                dsLiveSiteData.dtSiteDataStatusView.Clear();

                // Populate the List of TCPIP Addresses
                XmlNodeList SiteNodes = SiteConfig.SiteConfigurationXML.SelectNodes("//*[local-name()='UnitMap']");
                foreach (XmlNode mapNode in SiteNodes)
                {
                    // The Combobox in the "Single Unit" screen.
                    cmbListOfIPAddress.Items.Add(mapNode.Attributes["TCPIPAddress"].InnerText);

                    object[] objarray = new object[12];
                    //objarray[0] = 7;
                    objarray[1] = Int32.Parse(mapNode.Attributes["UnitIndex"].InnerText);
                    objarray[2] = mapNode.Attributes["TCPIPAddress"].InnerText;
                    XmlNode unitDetailNode = SiteConfig.UnitDetailsXML.SelectSingleNode("//*[@UnitIndex='" + mapNode.Attributes["UnitIndex"].InnerText.Trim() + "']/UnitName");
                    objarray[3] = unitDetailNode.InnerText.Trim();
                    objarray[4] = false;
                    objarray[5] = false;
                    objarray[6] = false;
                    objarray[7] = false;
                    objarray[8] = false;
                    objarray[9] = false;
                    objarray[10] = false;
                    objarray[11] = false;

                    dsLiveSiteData.dtSiteDataStatusView.Rows.Add(objarray);
                }

            }
        }
        #endregion

        #region Form buttons Handlers
        #region Button Handlers: Configuration Settings
        private void btnDeviceProtocolSettingReset_Click(object sender, EventArgs e)
        {
            // Set protocol type to "BINARY" for BRAVA type systems.
            cmbDeviceProtocolEncoding.ResetText();

            // Set TCP Port number to 9000 (Brava Default)
            numDeviceProtocolPortNum.Value = 9000;

        }


        private void btnApplyConfigFile_Click(object sender, EventArgs e)
        {
            this.ReadSettings();
            this.PopulateFormFromXML();
        }

        private void btnSiteConfigFileOpen_Click(object sender, EventArgs e)
        {
            if (dlgOpenXMLFile.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                string xmlFileName = dlgOpenXMLFile.SafeFileName;
                EngineersTools.Properties.Settings.Default.SiteConfigurationXMLFile = xmlFileName;
                EngineersTools.Properties.Settings.Default.Save();
                txtConfigXMLFileName.Text = xmlFileName;
            }
        }
        #endregion

        #region Button Handler: Connect Unit Button.
        private void btnSingleConnect_Click(object sender, EventArgs e)
        {
            if (cmbListOfIPAddress.Text != string.Empty)
            {
                BravaConnection myConnection = new BravaConnection();

                myConnection.BravaIP = System.Net.IPAddress.Parse(cmbListOfIPAddress.Text);

                myConnection.BravaPort = (Int16)numDeviceProtocolPortNum.Value;

                RequestType myRequest = new RequestType();

                BravaSocket mySocket = new BravaSocket(myRequest, myConnection);

                try
                {
                    mySocket.OpenConnection();

                    mySocket.DoTransaction();

                    myConnection.rqStream.Close();

                    myRequest.ParseResultStream();

                    MessageBox.Show(myRequest.ResultXML.OuterXml);


                }
                catch (Exception)
                {
                    mySocket.SocketClient.Close();
                    throw;
                }
            }
        }
        #endregion

        #region Button Handlers: Read Switch States
        private void btnAllUnitPoll_Click(object sender, EventArgs e)
        {
            //int maxRows = dsLiveSiteData.dtSiteDataStatusView.Rows.Count;

            foreach (DataGridViewRow gridRow in dataGridView1.Rows)
            {
                if (gridRow.Cells[2].Value != null)
                {
                    System.Net.IPAddress unitIPAddr = System.Net.IPAddress.Parse(gridRow.Cells[2].Value.ToString());
                    Int16 unitPortNum = (Int16)numDeviceProtocolPortNum.Value;

                    XmlDocument xmlStatusBlock = new XmlDocument();
                    xmlStatusBlock = readSwitchStateXML(unitIPAddr, unitPortNum);

                    if (xmlStatusBlock != null)
                    {
                        XmlNode CircuitStateNode = xmlStatusBlock.SelectSingleNode("//*[@Task='3' and @Function='5' and @RecordType='3' and @RecordIndex='8']/following-sibling::node()/*[@RecordID='8']");
                        if (CircuitStateNode != null)
                        {

                            gridRow.Cells[4].Value = (CircuitStateNode.Attributes["Circuit1State"].InnerText == "Disconnected") ? CheckState.Unchecked : CheckState.Checked;
                            gridRow.Cells[5].Value = (CircuitStateNode.Attributes["Circuit2State"].InnerText == "Disconnected") ? CheckState.Unchecked : CheckState.Checked;
                            gridRow.Cells[6].Value = (CircuitStateNode.Attributes["Circuit3State"].InnerText == "Disconnected") ? CheckState.Unchecked : CheckState.Checked;
                            gridRow.Cells[7].Value = (CircuitStateNode.Attributes["Circuit4State"].InnerText == "Disconnected") ? CheckState.Unchecked : CheckState.Checked;
                            gridRow.Cells[8].Value = (CircuitStateNode.Attributes["Circuit5State"].InnerText == "Disconnected") ? CheckState.Unchecked : CheckState.Checked;
                            gridRow.Cells[9].Value = (CircuitStateNode.Attributes["Circuit6State"].InnerText == "Disconnected") ? CheckState.Unchecked : CheckState.Checked;
                            gridRow.Cells[10].Value = (CircuitStateNode.Attributes["Circuit7State"].InnerText == "Disconnected") ? CheckState.Unchecked : CheckState.Checked;
                            gridRow.Cells[11].Value = (CircuitStateNode.Attributes["Circuit8State"].InnerText == "Disconnected") ? CheckState.Unchecked : CheckState.Checked;

                        }

                    }

                }
            }

            dataGridView1.Update();

        }

        private void btnGetSingleSwitchState_Click(object sender, EventArgs e)
        {
            if (cmbListOfIPAddress.Text != string.Empty)
            {
                XmlDocument xmlStatusBlock = new XmlDocument();
                xmlStatusBlock = readSwitchStateXML(System.Net.IPAddress.Parse(cmbListOfIPAddress.Text), (Int16)numDeviceProtocolPortNum.Value);

                if (xmlStatusBlock != null)
                {
                    XmlNode CircuitStateNode = xmlStatusBlock.SelectSingleNode("//*[@Task='3' and @Function='5' and @RecordType='3' and @RecordIndex='8']/following-sibling::node()/*[@RecordID='8']");
                    if (CircuitStateNode != null)
                    {

                        cbSingleSw1.CheckState = (CircuitStateNode.Attributes["Circuit1State"].InnerText == "Disconnected") ? CheckState.Unchecked : CheckState.Checked;
                        cbSingleSw2.CheckState = (CircuitStateNode.Attributes["Circuit2State"].InnerText == "Disconnected") ? CheckState.Unchecked : CheckState.Checked;
                        cbSingleSw3.CheckState = (CircuitStateNode.Attributes["Circuit3State"].InnerText == "Disconnected") ? CheckState.Unchecked : CheckState.Checked;
                        cbSingleSw4.CheckState = (CircuitStateNode.Attributes["Circuit4State"].InnerText == "Disconnected") ? CheckState.Unchecked : CheckState.Checked;
                        cbSingleSw5.CheckState = (CircuitStateNode.Attributes["Circuit5State"].InnerText == "Disconnected") ? CheckState.Unchecked : CheckState.Checked;
                        cbSingleSw6.CheckState = (CircuitStateNode.Attributes["Circuit6State"].InnerText == "Disconnected") ? CheckState.Unchecked : CheckState.Checked;
                        cbSingleSw7.CheckState = (CircuitStateNode.Attributes["Circuit7State"].InnerText == "Disconnected") ? CheckState.Unchecked : CheckState.Checked;
                        cbSingleSw8.CheckState = (CircuitStateNode.Attributes["Circuit8State"].InnerText == "Disconnected") ? CheckState.Unchecked : CheckState.Checked;

                    }
                }
            }
        }
        #endregion

        #region Button Handlers: Write Switch States
        private void btnSendSingleSwitchState_Click(object sender, EventArgs e)
        {
            if (cmbListOfIPAddress.Text != string.Empty)
            {
                sendSwitchStateCommand(System.Net.IPAddress.Parse(cmbListOfIPAddress.Text), (Int16)numDeviceProtocolPortNum.Value,
                                        cbSingleSw1.Checked, cbSingleSw2.Checked, cbSingleSw3.Checked, cbSingleSw4.Checked,
                                        cbSingleSw5.Checked, cbSingleSw6.Checked, cbSingleSw7.Checked, cbSingleSw8.Checked);
            }
        }

        private void dataGridView1_RowHeaderMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            // Row Layout
            // Col[2]: IPAddress
            // Col[4]..[11] switch states
            System.Net.IPAddress unitIPAddr = System.Net.IPAddress.Parse(dataGridView1.Rows[e.RowIndex].Cells[2].Value.ToString());
            Int16 unitPortNum = (Int16)numDeviceProtocolPortNum.Value;

            sendSwitchStateCommand(unitIPAddr, unitPortNum,
                                    (bool)dataGridView1.Rows[e.RowIndex].Cells[4].EditedFormattedValue,
                                    (bool)dataGridView1.Rows[e.RowIndex].Cells[5].EditedFormattedValue,
                                    (bool)dataGridView1.Rows[e.RowIndex].Cells[6].EditedFormattedValue,
                                    (bool)dataGridView1.Rows[e.RowIndex].Cells[7].EditedFormattedValue,
                                    (bool)dataGridView1.Rows[e.RowIndex].Cells[8].EditedFormattedValue,
                                    (bool)dataGridView1.Rows[e.RowIndex].Cells[9].EditedFormattedValue,
                                    (bool)dataGridView1.Rows[e.RowIndex].Cells[10].EditedFormattedValue,
                                    (bool)dataGridView1.Rows[e.RowIndex].Cells[11].EditedFormattedValue
                                    );
            dataGridView1.Update();

            dataGridView1.EndEdit();
        }
        #endregion

        #endregion

        #region Private Methods
        private System.Xml.XmlDocument readSwitchStateXML(System.Net.IPAddress destIPAdr, Int16 destPortNum)
        {
            RequestStateBlock myRequest = new RequestStateBlock((byte)BravaCodes.StateBlockRecords.SwitchBankLS8);
            BravaConnection myConnection = new BravaConnection();
            BravaSocket mySocket = new BravaSocket(myRequest, myConnection);

            try
            {
                // Prepare Connection Parameters.
                myConnection.BravaIP = destIPAdr;
                myConnection.BravaPort = destPortNum;

                // Enact / Transmit the Request.
                mySocket.DoTransaction();

                if (myRequest.State == BravaTransaction.TransactionState.Completed)
                {
                    myRequest.ParseResultStream();
                }

                if (myRequest.State == BravaTransaction.TransactionState.Failed)
                {
                    MessageBox.Show("Transaction Failed.");
                }

                //MessageBox.Show(myRequest.ResultXML.OuterXml);

                return myRequest.ResultXML;

            }
            catch (System.Net.Sockets.SocketException ex)
            {
                if ((ex.ErrorCode == 10061) || (ex.ErrorCode == 10060) || (ex.ErrorCode == 10065) )
                {
                    return null;
                }
                else
                {
                    throw ex;
                }

            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                mySocket.SocketClient.Close();
            }

        }


        private void sendSwitchStateCommand(System.Net.IPAddress destIPAdr, Int16 destPortNum,
                                            bool swState1, bool swState2, bool swState3, bool swState4,
                                            bool swState5, bool swState6, bool swState7, bool swState8)
        {
            BravaCodes.SwitchState[] mySwitchStates = new BravaCodes.SwitchState[8];

            for (int x = 0; x <= 7; x++) mySwitchStates[x] = BravaCodes.SwitchState.SwitchOff;

            if (swState1)
                mySwitchStates[0] = BravaCodes.SwitchState.SwitchOn;
            if (swState2)
                mySwitchStates[1] = BravaCodes.SwitchState.SwitchOn;
            if (swState3) // cbSingleSw3.Checked)
                mySwitchStates[2] = BravaCodes.SwitchState.SwitchOn;
            if (swState4) // cbSingleSw4.Checked)
                mySwitchStates[3] = BravaCodes.SwitchState.SwitchOn;
            if (swState5) // cbSingleSw5.Checked)
                mySwitchStates[4] = BravaCodes.SwitchState.SwitchOn;
            if (swState6) // cbSingleSw6.Checked)
                mySwitchStates[5] = BravaCodes.SwitchState.SwitchOn;
            if (swState7) // cbSingleSw7.Checked)
                mySwitchStates[6] = BravaCodes.SwitchState.SwitchOn;
            if (swState8) // cbSingleSw8.Checked)
                mySwitchStates[7] = BravaCodes.SwitchState.SwitchOn;

            SwitchbankUpdate mySwitchbankUpdate = new SwitchbankUpdate(
                mySwitchStates[0],
                mySwitchStates[1],
                mySwitchStates[2],
                mySwitchStates[3],
                mySwitchStates[4],
                mySwitchStates[5],
                mySwitchStates[6],
                mySwitchStates[7]);

            // RequestStateBlock myReadBackVerify = new RequestStateBlock((byte)BravaCodes.StateBlockRecords.SwitchBankLS8);
            
            BravaConnection myConnection = new BravaConnection();
            myConnection.BravaIP = destIPAdr;
            myConnection.BravaPort = destPortNum;

            BravaSocket mySocket = new BravaSocket(mySwitchbankUpdate, myConnection);

            try
            {
                mySocket.DoTransaction();

                if (mySwitchbankUpdate.State == BravaTransaction.TransactionState.Completed)
                {
                    mySwitchbankUpdate.State = BravaTransaction.TransactionState.Closed;

                    //mySocket.Transaction = myReadBackVerify;

                    //mySocket.DoTransaction();

                    //if (myReadBackVerify.State == BravaTransaction.TransactionState.Completed)
                    //{
                    //    BravaCodes.SwitchState[] readbackStates = new BravaCodes.SwitchState[8];
                    //    readbackStates = myReadBackVerify.ParseSwitchStates(8);
                    //    // TODO: Utility function to extract the switch state from the StateBlock
                    //    if (myReadBackVerify.State == BravaTransaction.TransactionState.Closed)
                    //    {
                    //        if (mySwitchStates == readbackStates)
                    //        {
                    //            MessageBox.Show("ReadBack value differs from Set Value");

                    //        }
                    //    }

                    //}
                    //else
                    //{
                    //    MessageBox.Show("ReadBackVerify Failed.");
                    //}

                }
                else
                {
                    MessageBox.Show("SwitchBankUpdate Failed.");
                }

            }
            catch (Exception)
            {
                mySocket.SocketClient.Close();
                throw;
            }

        }
        #endregion

        private void cbAllUnitPollAutoTimer_CheckedChanged(object sender, EventArgs e)
        {
            if (cbAllUnitPollAutoTimer.CheckState == CheckState.Checked)
            {
                tmrPollAllUnit.Interval = (int)numAllUnitsAutoPollMinutes.Value * 60 * 1000;
                numAllUnitsAutoPollMinutes.Enabled = false;
                tmrPollAllUnit.Enabled = true;

            }
            else
            {
                tmrPollAllUnit.Enabled = false;
                numAllUnitsAutoPollMinutes.Enabled = true;
            }


        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }





    }
}
