/// entities, values, aggregates for the Conference domain
unit DomConferenceTypes;

{$MODE Delphi}

interface

uses
  SysUtils,
  Classes,
  SynCommons,
  mORMot;


implementation

initialization
  TJSONSerializer.RegisterObjArrayForJSON([
    ]);
end.
