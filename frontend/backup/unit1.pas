unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Menus, ContactManager, Unit2, Barev, BarevTypes, Unit3;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    ListBox1: TListBox;
    MenuItem1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    PopupMenu1: TPopupMenu;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure RefreshContactList;
    procedure Timer1Timer(Sender: TObject);
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



     FBarevClient := TBarevClient.Create(Edit1.Text, Edit2.Text);

          if FBarevClient.AvatarManager.MyAvatarPath <> '' then
  Image1.Picture.LoadFromFile(
    FBarevClient.AvatarManager.MyAvatarPath
  );

     FBarevClient.OnMessageReceived:= @OnMessageReceived;
FBarevClient.Start;

FContactManager := TContactManager.Create(FBarevClient);
FContactManager.LoadFromFile('contacts.txt');
RefreshContactList;


end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    // show avatar locally
    Image1.Picture.LoadFromFile(OpenDialog1.FileName);

    // tell Barev about it
    if not FBarevClient.LoadMyAvatar(OpenDialog1.FileName) then
      ShowMessage('Failed to load avatar');
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

  Buddy := FContactManager.GetContact(Index);

  Chat := TForm4.CreateChat(Self, FBarevClient, Buddy);
  Chat.Show;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
var
  Buddy: TBarevBuddy;
begin
  if ListBox1.ItemIndex < 0 then Exit;

  Buddy := FContactManager.GetContact(ListBox1.ItemIndex);

  if MessageDlg(
       'Remove buddy',
       'Remove ' + Buddy.JID + ' from contacts?',
       mtConfirmation,
       [mbYes, mbNo],
       0
     ) = mrYes then
  begin
    FBarevClient.RemoveBuddy(Buddy.JID);
    FContactManager.SaveToFile('contacts.txt');
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
  for I := 0 to FContactManager.Count - 1 do
  begin
    Buddy := FContactManager.GetContact(I);
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
      FContactManager.AddContact(AddForm.Nick, AddForm.IPv6);
      RefreshContactList;
      FContactManager.SaveToFile('contacts.txt');

    end;
  finally
    AddForm.Free;
  end;
end;

procedure TForm1.OnMessageReceived(
  Buddy: TBarevBuddy;
  const MessageText: string
);
begin
  // example
  ShowMessage(Buddy.Nick + ': ' + MessageText);
end;







end.

