{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit SynopsePkg;

{$warn 5023 off : no warning about unused units}
interface

uses
  PasZip, SynBidirSock, SynBigTable, SynCommons, SynCrtSock, SynCrypto, SynDB, 
  SynDBDataset, SynDBODBC, SynDBOracle, SynDBRemote, SynDBSQLite3, SynEcc, 
  SynFastWideString, SynFPCTypInfo, SynLizard, SynLog, SynLZ, SynLZO, 
  SynMongoDB, SynMustache, SynOleDB, SynOpenSSL, SynProtoRTSPHTTP, SynSM, 
  SynSMAPI, SynSQLite3, SynSQLite3Static, SynSSPI, SynSSPIAuth, SynTable, 
  SynTests, SynVirtualDataSet, SynWinSock, SynZip, SynZipFiles, SynZLibSSE, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('SynopsePkg', @Register);
end.
