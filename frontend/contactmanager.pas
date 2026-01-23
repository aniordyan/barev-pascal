unit ContactManager;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Barev, BarevTypes;

type
  TContact = record
    Nick: string;
    IPv6: string;
  end;

  TContactManager = class
  private
    FClient: TBarevClient;
  public
    constructor Create(AClient: TBarevClient);

    procedure AddContact(const ANick, AIPv6: string);
    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);

    function Count: Integer;
    function GetContact(Index: Integer): TBarevBuddy;
  end;

implementation

constructor TContactManager.Create(AClient: TBarevClient);
begin
  FClient := AClient;
end;

procedure TContactManager.AddContact(const ANick, AIPv6: string);
begin
  FClient.AddBuddy(ANick, AIPv6, BAREV_DEFAULT_PORT);
end;

procedure TContactManager.LoadFromFile(const FileName: string);
begin
  FClient.LoadContactsFromFile(FileName);
end;

procedure TContactManager.SaveToFile(const FileName: string);
begin
  FClient.SaveContactsToFile(FileName);
end;

function TContactManager.Count: Integer;
begin
  Result := FClient.GetBuddyCount;
end;

function TContactManager.GetContact(Index: Integer): TBarevBuddy;
begin
  Result := FClient.GetBuddyByIndex(Index);
end;


end.

