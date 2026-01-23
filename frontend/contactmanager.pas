unit ContactManager;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  TContact = record
    Nick: string;
    IPv6: string;
  end;

  TContactManager = class
  private
    FContacts: array of TContact;
  public
    procedure AddContact(const ANick, AIPv6: string);
    function Count: Integer;
    function GetContact(Index: Integer): TContact;
  end;

implementation

procedure TContactManager.AddContact(const ANick, AIPv6: string);
var
  C: TContact;
begin
  C.Nick := ANick;
  C.IPv6 := AIPv6;

  SetLength(FContacts, Length(FContacts) + 1);
  FContacts[High(FContacts)] := C;
end;

function TContactManager.Count: Integer;
begin
  Result := Length(FContacts);
end;

function TContactManager.GetContact(Index: Integer): TContact;
begin
  Result := FContacts[Index];
end;

end.

