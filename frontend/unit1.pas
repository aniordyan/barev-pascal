unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, ContactManager, Unit2, Barev, BarevTypes;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    ListBox1: TListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure RefreshContactList;
  private
    FContactManager: TContactManager;
    FBarevClient: TBarevClient;


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
FBarevClient.Start;

FContactManager := TContactManager.Create(FBarevClient);
FContactManager.LoadFromFile('contacts.txt');
RefreshContactList;

end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin

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








end.

