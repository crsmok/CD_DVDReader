unit u_drive_utils;

interface

  uses

    Windows, SysUtils, MMSystem;

  function CloseCD(Drive: Char): Boolean;

  function OpenCD(Drive: Char): Boolean;

  function DiskInDrive(lw: Char ): integer;

implementation

  function OpenCD(Drive: Char): Boolean;
  var
    Res: MciError;
    OpenParm: TMCI_Open_Parms;
    Flags: DWord;
    S: string;
    DeviceID: Word;
  begin
      Result := false;
      S := Drive + ':';
      Flags := mci_Open_Type or mci_Open_Element;

      with OpenParm do
      begin
         dwCallback := 0;
         lpstrDeviceType := 'CDAudio';
         lpstrElementName := PChar(S);
      end;
      Res := mciSendCommand(0, mci_Open, Flags, Longint(@OpenParm));
      if Res <> 0 then
         exit;
      DeviceID := OpenParm.wDeviceID;
      try
         Res := mciSendCommand(DeviceID, MCI_SET, MCI_SET_DOOR_OPEN, 0);
         if Res = 0 then
           exit;
         Result := True;
      finally
         mciSendCommand(DeviceID, mci_Close, Flags, Longint(@OpenParm));
      end;

  end;

  function CloseCD(Drive: Char): Boolean;
  var
    Res: MciError;
    OpenParm: TMCI_Open_Parms;
    Flags: DWord;
    S: string;
    DeviceID: Word;
  begin
    Result := false;
    S := Drive + ':';
    Flags := mci_Open_Type or mci_Open_Element;
    with OpenParm do
    begin
       dwCallback := 0;
       lpstrDeviceType := 'CDAudio';
       lpstrElementName := PChar(S);
    end;
    Res := mciSendCommand(0, mci_Open, Flags, Longint(@OpenParm));
    if Res <> 0 then
       exit;
    DeviceID := OpenParm.wDeviceID;
    try
       Res := mciSendCommand(DeviceID, MCI_SET, MCI_SET_DOOR_CLOSED, 0);
       if Res = 0 then
         exit;
       Result := True;
    finally
       mciSendCommand(DeviceID, mci_Close, Flags, Longint(@OpenParm));
    end;
  end;


  function DiskInDrive(lw: Char ): integer;
  var
    sRec: TSearchRec;
    res: integer;

  begin
      Result:= 0;
      SetErrorMode(SEM_FAILCRITICALERRORS);
      //result := False;
      {$I-}
        res := FindFirst(lw + ':\*.*', faAnyfile, SRec );
        FindClose(SRec);
      {$I+}
      case res of
         0     : Result := 0;
         2,18  : Result := 1;
         21,3  : Result := 2;
      else
        Result := res;
      end;
  end;

end.
