unit addcontactform;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TAddContactForm }

  TAddContactForm = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
  private

  public
    Nick: string;
    IPv6: string;

  end;

var
  Form2: TAddContactForm;

implementation

{$R *.lfm}

{ TAddContactForm }

procedure TAddContactForm.Button1Click(Sender: TObject);
begin
    Nick := Edit1.Text;
    IPv6 := Edit2.Text;
    ModalResult := mrOK;
end;

procedure TAddContactForm.Edit1Change(Sender: TObject);
begin

end;

procedure TAddContactForm.Edit2Change(Sender: TObject);
begin

end;

end.

