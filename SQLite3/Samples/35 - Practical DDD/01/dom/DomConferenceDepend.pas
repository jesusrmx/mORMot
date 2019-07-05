/// Conference Domain dependencies interface definition
unit DomConferenceDepend;

{$MODE Delphi}

interface

uses
  SysUtils,
  Classes,
  SynCommons,
  mORMot,
  DomConferenceTypes;


implementation

initialization
  TJSONSerializer.RegisterObjArrayForJSON([
    ]);
  TInterfaceFactory.RegisterInterfaces([
    ]);
end.
