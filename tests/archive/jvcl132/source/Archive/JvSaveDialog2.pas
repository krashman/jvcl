{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvSaveDialog2.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is Sébastien Buysse [sbuysse@buypin.com]
Portions created by Sébastien Buysse are Copyright (C) 2001 Sébastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck@bigfoot.com].

Last Modified: 2000-02-28

You may retrieve the latest version of this file at the Project JEDI home page,
located at http://www.delphi-jedi.org

Known Issues:
-----------------------------------------------------------------------------}
{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$I JEDI.INC}

unit JvSaveDialog2;

{$ObjExportAll On}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CommDlg, StdCtrls,
  JvDialogsEx, JvOpenDialog2;

type
  TJvSaveDialog2 = class(TJvOpenDialog2)
  public
    function Execute: Boolean; override;
  end;

implementation

var
  ShowPlaces: Boolean;

{**************************************************}

function ExecuteHandler(var DialogData: TOpenFileName): Bool; stdcall;
var
  DialogDataEx: TOpenFileNameEx;
begin
  Move(DialogData, DialogDataEx, SizeOf(DialogData));
  if ShowPlaces then
    DialogDataEx.FlagsEx := 0
  else
    DialogDataEx.FlagsEx := OFN_EX_NOPLACESBAR;
  DialogDataEx.lStructSize := SizeOf(TOpenFileNameEx);
  Result := GetSaveFileNameEx(DialogDataEx);
end;

{**************************************************}

function TJvSaveDialog2.Execute: Boolean;
begin
  FilterIndex := FilterIndex; //To correct a bug with the new dialogs!
  if OsCompliant then
  begin
    ShowPlaces := OptionsEx.PlacesBar;
    Result := DoExecute(@ExecuteHandler);
  end
  else
    Result := inherited Execute;
end;

end.
