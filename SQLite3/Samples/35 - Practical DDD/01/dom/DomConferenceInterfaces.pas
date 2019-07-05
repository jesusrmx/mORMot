/// Conference Domain services interfaces definition
unit DomConferenceInterfaces;

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
