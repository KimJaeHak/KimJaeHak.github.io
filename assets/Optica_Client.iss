; Optica Client Packing Script

[Setup]
AppName=Optica
AppVersion=1.0
AppendDefaultDirName=no
AppendDefaultGroupName=no
CloseApplications=force
CreateAppDir=yes
CreateUninstallRegKey=no
DefaultDirName=d:\mirero\optica
DefaultGroupName=Optica
UsePreviousAppDir=no
OutputBaseFilename=Optica_Client_Setup
OutputDir=d:\Document\PROJECT_DOC\Document\OpticaDoc\Deploy\Setup\
Uninstallable=no

[Files]
Source: "d:\Temp\OPTICA_RELEASE_HY\20210528_Release\Client\*"; Excludes: "\log\*,*.pdb"; Flags: ignoreversion recursesubdirs overwritereadonly; DestDir: "{app}"


[Code]

procedure DirectoryCopy(SourcePath, DestPath: string);
var
  FindRec: TFindRec;
  SourceFilePath: string;
  DestFilePath: string;
begin
  if FindFirst(SourcePath + '\*', FindRec) then
  begin
    try
      repeat
        if (FindRec.Name <> '.') and (FindRec.Name <> '..') then
        begin
          SourceFilePath := SourcePath + '\' + FindRec.Name;
          DestFilePath := DestPath + '\' + FindRec.Name;
          if FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY = 0 then
          begin
            if FileCopy(SourceFilePath, DestFilePath, False) then
            begin
              Log(Format('Copied %s to %s', [SourceFilePath, DestFilePath]));
            end
              else
            begin
              Log(Format('Failed to copy %s to %s', [SourceFilePath, DestFilePath]));
            end;
          end
            else
          begin
            if DirExists(DestFilePath) or CreateDir(DestFilePath) then
            begin
              Log(Format('Created %s', [DestFilePath]));
              DirectoryCopy(SourceFilePath, DestFilePath);
            end
              else
            begin
              Log(Format('Failed to create %s', [DestFilePath]));
            end;
          end;
        end;
      until not FindNext(FindRec);
    finally
      FindClose(FindRec);
    end;
  end
    else
  begin
    Log(Format('Failed to list %s', [SourcePath]));
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  SourcePath: string;
  DestPath: string;
begin
  begin
    SourcePath := ExpandConstant('{app}');
    DestPath := ExpandConstant('{app}\..\_backup');
    Log(Format('Backing up %s to %s before installation', [SourcePath, DestPath]));
    if not ForceDirectories(DestPath) then
    begin
      Log(Format('Failed to create %s', [DestPath]));
    end
      else
    begin
      DirectoryCopy(SourcePath, DestPath);
    end;
  end;
end;

