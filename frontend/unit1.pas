unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Menus, ComboEx, ContactManager, Unit2, Barev, BarevTypes, Unit3;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    MenuItem1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    PopupMenu1: TPopupMenu;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure RefreshContactList;
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    FContactManager: TContactManager;
    FBarevClient: TBarevClient;
    procedure OnMessageReceived(Buddy: TBarevBuddy; const MessageText: string);

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
     FBarevClient := nil;
     FContactManager := nil;


end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  if not Assigned(FBarevClient) then
  begin
    ShowMessage('Please press Start first');
    Exit;
  end;

  if OpenDialog1.Execute then
  begin
    // show avatar locally
    Image1.Picture.LoadFromFile(OpenDialog1.FileName);

    // register avatar in backend
    FBarevClient.LoadMyAvatar(OpenDialog1.FileName);
  end;
end;


procedure TForm1.ListBox1Click(Sender: TObject);
begin

end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
var
  Index: Integer;
  Buddy: TBarevBuddy;
  Chat: TForm4;
begin
  Index := ListBox1.ItemIndex;
  if Index < 0 then Exit;

  Buddy := FBarevClient.GetBuddyByIndex(ListBox1.ItemIndex);



  Chat := TForm4.CreateChat(Self, FBarevClient, Buddy);
  Chat.Show;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
var
  Buddy: TBarevBuddy;
begin
 Buddy := FBarevClient.GetBuddyByIndex(ListBox1.ItemIndex);

if FBarevClient.RemoveBuddy(Buddy.JID) then
begin
  FBarevClient.SaveConfig;
  RefreshContactList;
end;

end;


procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin

end;

procedure TForm1.RefreshContactList;
var
  I: Integer;
  Buddy: TBarevBuddy;
begin
  ListBox1.Clear;

  if not Assigned(FBarevClient) then Exit;

  for I := 0 to FBarevClient.GetBuddyCount - 1 do
  begin
    Buddy := FBarevClient.GetBuddyByIndex(I);
    ListBox1.Items.Add(Buddy.JID);
  end;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if Assigned(FBarevClient) then
    FBarevClient.Process;
end;

procedure TForm1.Button1Click(Sender: TObject);

var
  AddForm: TForm3;
begin
  AddForm := TForm3.Create(Self);
  try
    if AddForm.ShowModal = mrOK then
    begin
      FBarevClient.AddBuddy(AddForm.Nick, AddForm.IPv6);
      FBarevClient.SaveConfig;
      RefreshContactList;


    end;
  finally
    AddForm.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if Assigned(FBarevClient) then Exit;

  if Trim(Edit1.Text) = '' then
  begin
    ShowMessage('Please enter your nickname');
    Exit;
  end;

  if Trim(Edit2.Text) = '' then
  begin
    ShowMessage('Please enter your IPv6 address');
    Exit;
  end;

  FBarevClient := TBarevClient.Create(Edit1.Text, Edit2.Text);
  FBarevClient.OnMessageReceived := @OnMessageReceived;

  FBarevClient.LoadConfig(GetUserDir + '.barev' + PathDelim + 'barev.ini');

  // load avatar from backend if available
if (FBarevClient.AvatarManager.MyAvatarPath <> '') and
   FileExists(FBarevClient.AvatarManager.MyAvatarPath) then
begin
  Image1.Picture.LoadFromFile(
    FBarevClient.AvatarManager.MyAvatarPath
  );
end;


  Edit1.Text := FBarevClient.Nick;
  Edit2.Text := FBarevClient.MyIPv6;
  //set image

  FBarevClient.Start;

  FContactManager := TContactManager.Create(FBarevClient);
  RefreshContactList;

  Timer1.Enabled := True;

  Edit1.Enabled := False;
  Edit2.Enabled := False;
  Button2.Enabled := False;
end;

procedure TForm1.OnMessageReceived(
  Buddy: TBarevBuddy;
  const MessageText: string
);
begin
  // example
  ShowMessage(Buddy.Nick + ': ' + MessageText);
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if Assigned(FBarevClient) then
    FBarevClient.SaveConfig;
end;







end.

