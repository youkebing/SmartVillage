using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Net.Sockets;

namespace BravaSystem.Communication
{
    /// <summary>
    /// Sockets Transceiver for BRAVA systems.
    /// </summary>
    public class BravaSocket
    {
        // private members
        private TcpClient reqClient;

        // ctors
        public BravaSocket(BravaTransaction inTransaction, BravaConnection inConnection)
        {
            this.Connection = inConnection;
            this.Transaction = inTransaction;
        }

        // public members
        public BravaTransaction Transaction;
        public BravaConnection Connection;
        public TcpClient SocketClient
        {
            get { return reqClient; }
            set { reqClient = value; }
        }

        #region Private Methods
        // private methods

        // Issue a request to the defined Connection Endpoint.
        private void SendRequest(Stream outData)
        {
            SendFrame(Transaction.RequestStream, Connection.rqStream);
        }

        // Get a response to a request (Act as Client)
        private Stream GetResponse()
        {
            Stream outputStr = GetFrame(Connection.rqStream);

            return outputStr;
        }

        // Send a frame of "data" to the Network stream specified
        private void SendFrame(Stream outData, NetworkStream nStream)
        {
            int numberOfBytes = 0;
            int total = 0;
            Byte[] bytes = new Byte[256];

            try
            {
                outData.Seek(0, SeekOrigin.Begin);

                numberOfBytes = outData.Read(bytes, 0, bytes.Length);

                do
                {
                    nStream.Write(bytes, 0, numberOfBytes);
                    total += numberOfBytes;
                    numberOfBytes = outData.Read(bytes, 0, bytes.Length);
                } while (numberOfBytes > 0);
            }
            catch (SocketException e)
            {
                System.Diagnostics.Debug.WriteLine("Exception BravaSockets:SendFrame: " + e.Message);
            }
        }

        // Gets a frame from the specified stream 
        private Stream GetFrame(NetworkStream nStream)
        {
            Byte[] bytes = new Byte[256];

            int numberOfBytesRead = 0;
            int total = 0;
            MemoryStream data = new MemoryStream();
            try
            {
                // Loop to receive all the data sent by the client.
                do
                {
                    numberOfBytesRead = nStream.Read(bytes, 0, bytes.Length);
                    data.Write(bytes, 0, numberOfBytesRead);
                    total += numberOfBytesRead;
                }
                while (nStream.DataAvailable);
            }
            catch (SocketException e)
            {
                System.Diagnostics.Debug.WriteLine("Exception TCPSockets:GetFrame: " + e.Message);
            }
            return data;
        }
        #endregion

        // public methods
        public void OpenConnection()
        {
            try
            {
                reqClient = new TcpClient();
                reqClient.NoDelay = false;
                reqClient.ReceiveTimeout = 2000;
                reqClient.SendTimeout = 2000;
                LingerOption lingerOption = new LingerOption(true, 0);
                reqClient.LingerState = lingerOption;
                reqClient.Connect(Connection.BravaIP, Connection.BravaPort);
                Connection.rqStream = reqClient.GetStream();
            }
            catch (SocketException se)
            {
                throw(se);
            }
        }

        // Perform the Transaction on the Connection specified.
        public void DoTransaction()
        {
            SendRequest(Transaction.RequestStream);

            // TODO: A better timeout / wait for response methodology here.
            //System.Threading.Thread.Sleep(200);

            if (Connection.rqStream.DataAvailable)
            {
                Transaction.ResponseStream = GetResponse();
            }

            Transaction.RequestStream.Close();
        }
            
    }
}
