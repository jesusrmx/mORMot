/// serve SQLite3 results from SQL using HTTP server
program JSONSQLServer;

{$MODE Delphi}

{

  This "13 - StandAlone JSON SQL server" sample's aim is to directly
    serve SQLite3 JSON results from SQL using HTTP server.

  It will expect the incoming SQL statement to be POSTED as HTTP body, which
  will be executed and returned as JSON.

  This default implementation will just serve the test.db3 file as generated
  by our regression tests.

  SETUP NOTE: Ensure you first copied in the sample exe folder the test.db3 file
  as generated by TestSQL3.exe.

  But it is a very rough mechanism:
  - No security is included;
  - You can make your process run out of memory if the request returns too much rows;
  - All incoming inputs will not be checked;
  - No statement cache is used;
  - No test was performed;
  - Consider using SynDBRemote unit instead, for remote SQL access.

  Therefore, this method is much less efficient than the one implemented by mORMot.
  This is just a rough sample - do not use it in production - you shall better
  use the mORMot framework instead.

  Using SynDB classes instead of directly SynSQLite3 will allow to use any other DB,
  not only SQlite3.

  see https://synopse.info/forum/viewtopic.php?id=607 for the initial request
  
}

{$APPTYPE CONSOLE}

uses
  {$I SynDprUses.inc} // use FastMM4 on older Delphi, or set FPC threads
  SysUtils,
  Classes,
  SynCommons,
  SynZip,
  SynDB,
  SynDBSQLite3, SynSQLite3Static,
  SynCrtSock;

type
  TJSONServer = class
  protected
    fProps: TSQLDBConnectionProperties;
    fServer: THttpApiServer;
    function Process(Ctxt: THttpServerRequest): cardinal;
  public
    constructor Create(Props: TSQLDBConnectionProperties);
    destructor Destroy; override;
  end;


{ TJSONServer }

const
  DEFAULT_PORT = {$ifdef LINUX} '8888' {$else} '888' {$endif};

constructor TJSONServer.Create(Props: TSQLDBConnectionProperties);
var Conn: TSQLDBConnection;
begin
  fProps := Props;
  Conn := fProps.ThreadSafeConnection;
  if not Conn.Connected then
    Conn.Connect; // ensure we can connect to the DB
  fServer := THttpApiServer.Create(false);
  fServer.AddUrl('root',DEFAULT_PORT,false,'+',true);
  fServer.RegisterCompress(CompressDeflate); // our server will deflate JSON :)
  fServer.OnRequest := Process;
  fServer.Clone(31); // will use a thread pool of 32 threads in total
end;

destructor TJSONServer.Destroy;
begin
  fServer.Free;
  inherited;
end;

function TJSONServer.Process(Ctxt: THttpServerRequest): cardinal;
begin
  try
    if length(Ctxt.InContent)<5 then
      raise ESynException.CreateUTF8('Invalid request % %',[Ctxt.Method,Ctxt.URL]);
    Ctxt.OutContentType := JSON_CONTENT_TYPE;
    Ctxt.OutContent := fProps.Execute(Ctxt.InContent,[]).FetchAllAsJSON(true);
    result := 200;
  except
    on E: Exception do begin
      Ctxt.OutContentType := TEXT_CONTENT_TYPE;
      Ctxt.OutContent := StringToUTF8(E.ClassName+': '+E.Message)+#13#10+Ctxt.InContent;
      result := 504;
    end;
  end;
end;

var Props: TSQLDBConnectionProperties;
begin
  // copy in the sample exe folder the test.db3 file as generated by TestSQL3.exe 
  Props := TSQLDBSQLite3ConnectionProperties.Create('test.db3','','','');
  try
    with TJSONServer.Create(Props) do
    try
      write('Server is now running on http://localhost:',
        DEFAULT_PORT,'/root'#13#10'and will serve ',
        ExpandFileName(UTF8ToString(Props.ServerName)),
        ' content'#13#10#13#10'Press [Enter] to quit');
      readln;
    finally
      Free;
    end;
  finally
    Props.Free;
  end;
end.
