//
//  TcpClient.swift
//  nodatron
//
//  Created by Kenneth Centurion on 1/28/16.
//  Copyright © 2016 Kenneth Centurion. All rights reserved.
//

import Foundation

class TcpClient {
    
    var host: String;
    var port: Int;
    var socketFD = socket(PF_INET, SOCK_STREAM, 0)
    
    init(host: String, port: Int) {
        self.host = host;
        self.port = port;
    }
    
    func sendData(data : String) -> Int{
        
        let textCString = data.cStringUsingEncoding(NSASCIIStringEncoding)
        let textLength  = Int(data.lengthOfBytesUsingEncoding(NSASCIIStringEncoding))
        let sendResult  = send(socketFD, textCString!, textLength, 0)
        //let responseFromServer: String
        
        if sendResult != -1 {
            NSLog("Successfully sent:"+data);
            
            /*
            let receiveLength = 2*textLength
            var receiveBuffer = [CChar](count:Int(receiveLength), repeatedValue:0)
            
            
            let recvResult = recv(socketFD, &receiveBuffer, Int(receiveBuffer.count), 0)
            if recvResult >= 0 {
                responseFromServer = String.fromCString(receiveBuffer)!
            } else {
                // failed the recv
                responseFromServer = "recv failure: \(recvResult)"
            }
            */
        } else {
            // failed the send
            //responseFromServer = "send failure: \(sendResult)"
            NSLog("Failed to send:"+data);
            return -1;
        }
        
        //NSLog(responseFromServer);
        
        return 0;
    }
    
   
    func connectToNodatron() {
        let hostAddress = host // IPv4 address of server
        let hostAddressArray = hostAddress.cStringUsingEncoding(NSASCIIStringEncoding)!
        let hostAddr = inet_addr(hostAddressArray)
        let responseFromServer: String
        
        if 0 <= socketFD {
            let rport:UInt16 = UInt16(port)
            
            var serverAddr = sockaddr_in (
                sin_len    : __uint8_t(sizeof(sockaddr_in)),
                sin_family : sa_family_t(AF_INET),
                sin_port   : rport.bigEndian,
                sin_addr   : in_addr(s_addr: hostAddr),
                sin_zero   : (0,0,0,0,0,0,0,0))
           
            let connectResultCode = withUnsafePointer(&serverAddr) { pointer -> Int32 in
                let localSockAddr = UnsafePointer<sockaddr>(pointer)
                return connect(socketFD, localSockAddr, socklen_t(sizeof(sockaddr_in)))
            }
            
            if connectResultCode >= 0 {
                responseFromServer = "successfully connected to Nodatron server"
            }
            else {
                // failed the connect
                responseFromServer = "failed to connect"
            }
            //close(socketFD)
        } else {
            // failed to create the socket
            responseFromServer = "failed to create socket"
        }
        
        
        NSLog(responseFromServer);
    }//sendData




}//end class