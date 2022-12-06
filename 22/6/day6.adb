with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

procedure Day6 is
  package Int_IO is new Ada.Text_IO.Integer_IO (Integer);

  File_Name : constant String := "day6_in";
  F : File_Type; 

  function First_Packet_Loc return Integer is
    type UInt4 is mod 4;
    type Arr is array (UInt4'Range) of Character;

    Count: Integer := 0;
    Unique : UInt4 := 0;
    C : Character;
    Four : Arr := ('0', '0', '0', '0');
  begin
    Open (F, In_File, File_Name);

    while not End_Of_File (F) loop
      Get (F, C);
      Count := Count + 1;

      Four (Unique) := C; 
      if Count > 4 and
         C /= Four (Unique - 1) and C /= Four (Unique - 2) and
         C /= Four (Unique - 3) and Four (Unique - 1) /= Four (Unique - 2) and
         Four (Unique - 1) /= Four (Unique - 3) and 
         Four (Unique - 2) /= Four (Unique - 3) then
         Close (F);
        return Count;
      end if;
      Unique := Unique + 1;
    end loop;
    Close (F);
    return -1;
  end First_Packet_Loc;

  function First_Message_Loc return Integer is
    Msg : String (1..14) := "              ";
    C : Character;
    Count : Integer := 0;
    Unique : Natural := 1;
    Idx : Natural;
  begin
    Open (F, In_File, File_Name);

    while not End_Of_File (F) loop
      Get (F, C);
      Count := Count + 1;

      Idx := Index (Msg, C & "");
      if Idx /= 0 then
        Msg := Msg (Idx+1 .. Msg'Last) & (Idx+1 - Msg'First) * ' ';
        Unique := Unique - Idx;
      end if;
      Msg (Unique) := C; Unique := Unique + 1;
      Put_Line (Msg);

      if Unique = 15 then
        Close (F); return Count;
      end if;
    end loop;

    Close (F);
    return -1;
  end First_Message_Loc;

begin

  Put_Line ("The number of characters to the end of the first start-of-packet is"
            & First_Packet_Loc'Image);

  Put_Line ("The number of characters to the end of the first start-of-message is"
            & First_Message_Loc'Image);

end Day6;
