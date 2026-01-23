unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, ContactManager, Unit2;

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
    procedure RefreshContactList;
  private
    FContactManager: TContactManager;


  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
    FContactManager := TContactManager.Create;
end;

procedure TForm1.Image1Click(Sender: TObject);
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
  C: TContact;
begin
  ListBox1.Clear;
  for I := 0 to FContactManager.Count - 1 do
  begin
    C := FContactManager.GetContact(I);
    ListBox1.Items.Add(C.Nick + ' [' + C.IPv6 + ']');
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);

begin

end;








end.

