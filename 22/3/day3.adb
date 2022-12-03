with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Bounded;

procedure Day3 is
  package B_Str is new
    Ada.Strings.Bounded.Generic_Bounded_Length (Max => 48);
  use B_Str;

  File_Name : constant String := "day3_in";
  F : File_Type;

  procedure Split (Input : String; First, Last : out Bounded_String) is
  begin
    First := To_Bounded_String (Input (Input'First .. Input'First + Input'Length / 2 - 1));
    Last := To_Bounded_String (Input (Input'First + Input'Length / 2 .. Input'Last));
  end Split;

  function Get_Priority (C : Character) return Integer is
  begin
    case C is
      when 'a'..'z' => return Character'Pos (C) - Character'Pos ('a') + 1;
      when 'A'..'Z' => return Character'Pos (C) - Character'Pos ('A') + 27;
      when others => return 0;
    end case;
  end Get_Priority;

  function Sum_Priorities return Integer is
    First, Last : Bounded_String;
    Break : Boolean := False;
    Priority_Sum : Integer := 0;
    C : Character;
  begin
    Open (F, In_File, File_Name);

    while not End_Of_File (F) loop
      Split (Get_Line (F), First, Last);
      for I in 1 .. Length (First) loop
        Break := False;
        C := Element (First, I);

        for J in 1 .. Length (Last) loop
          if C = Element (Last, J) then
            Priority_Sum := Priority_Sum + Get_Priority (C);
            Break := True;
            exit;
          end if;
        end loop;

        exit when Break = True;
      end loop;
    end loop;

    Close (F);
    return Priority_Sum;
  end Sum_Priorities;

  function Sum_Group_Priorities return Integer is
    S1, S2, S3 : Bounded_String;

    C : Character;
    Priority_Sum : Integer := 0;
  begin
    Open (F, In_File, File_Name);
    while not End_Of_File (F) loop
      S1 := To_Bounded_String (Get_Line (F));
      S2 := To_Bounded_String (Get_Line (F));
      S3 := To_Bounded_String (Get_Line (F));
      for I in 1 .. Length (S1) loop
        C := Element (S1, I);
        if Index (S2, C & "") > 0 and 
           Index (S3, C & "") > 0 then
          Priority_Sum := Priority_Sum + Get_Priority (C);
          exit;
        end if;
      end loop;
    end loop;
    Close (F);

    return Priority_Sum;
  end Sum_Group_Priorities;

begin

  Put_Line ("The sum of priorities is" & Sum_Priorities'Image);
  Put_Line ("The sum of group priorities is" & Sum_Group_Priorities'Image);

end Day3;
