unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Barev, BarevTypes;

type

  { TForm4 }

  TForm4 = class(TForm)
    Memo1: TMemo;
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private
     FClient: TBarevClient;
    FBuddy: TBarevBuddy;
  public
     constructor CreateChat(AOwner: TComponent;
      AClient: TBarevClient;
      ABuddy: TBarevBuddy);
    procedure AddIncomingMessage(const Msg: string);
  end;

var
  Form4: TForm4;

implementation

{$R *.lfm}

{ TForm4 }

constructor TForm4.CreateChat(
  AOwner: TComponent;
  AClient: TBarevClient;
  ABuddy: TBarevBuddy);
begin
  inherited Create(AOwner);
  FClient := AClient;
  FBuddy := ABuddy;

  Caption := 'Chat with ' + FBuddy.Nick;
end;


procedure TForm4.Button1Click(Sender: TObject);
var
  Msg: string;
begin
  Msg := Trim(Edit1.Text);
  if Msg = '' then Exit;

  FClient.SendMessage(FBuddy.JID, Msg);

  Memo1.Lines.Add('Me: ' + Msg);
  Edit1.Clear;

end;

procedure TForm4.Edit1Change(Sender: TObject);
begin

end;

procedure TForm4.AddIncomingMessage(const Msg: string);
begin
  Memo1.Lines.Add(FBuddy.Nick + ': ' + Msg);
end;


procedure TForm4.Memo1Change(Sender: TObject);
begin

end;

end.

