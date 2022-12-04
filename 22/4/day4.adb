with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Bounded;

procedure Day4 is
  package Int_IO is new Ada.Text_IO.Integer_IO (Integer);
  package B_Str is new 
    Ada.Strings.Bounded.Generic_Bounded_Length (Max => 10);
  use B_Str;

  File_Name : constant String := "day4_in";
  F : File_Type;

  procedure Read_Four_Int (F : File_Type; L1, L2, U1, U2 : out Integer) is
    C : Character;
  begin
      Int_IO.Get (F, L1); Get (F, C);
      Int_IO.Get (F, U1); Get (F, C);
      Int_IO.Get (F, L2); Get (F, C);
      Int_IO.Get (F, U2);
  end Read_Four_Int;

  function Count_Contained return Integer is
    Contained : Integer := 0;
    L1, L2, U1, U2 : Integer;
  begin
    Open (F, In_File, File_Name);

    while not End_Of_File (F) loop
      Read_Four_Int (F, L1, L2, U1, U2);

      if (L1 <= L2 and U1 >= U2) 
      or (L2 <= L1 and U2 >= U1) then
        Contained := Contained + 1;
      end if;
    end loop;

    Close (F);
    return Contained;
  end Count_Contained;

  function Count_Overlap return Integer is
    Overlapped : Integer := 0;
    L1, L2, U1, U2 : Integer;
  begin
    Open (F, In_File, File_Name);

    while not End_Of_File (F) loop
      Read_Four_Int (F, L1, L2, U1, U2);

      if not (L1 > U2 or L2 > U1) then
        Overlapped := Overlapped + 1;
      end if;
    end loop;

    Close (F);
    return Overlapped;
  end Count_Overlap;

begin

  Put_Line ("The number of fully contained pairs is" & Count_Contained'Image);
  Put_Line ("The number of overlapping pairs is" & Count_Overlap'Image);

end Day4;
