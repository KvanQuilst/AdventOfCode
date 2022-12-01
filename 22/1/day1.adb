with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Bounded;

procedure Day1 is
  package B_Str is new
    Ada.Strings.Bounded.Generic_Bounded_Length (Max => 6);
  use B_Str;

  File_Name : constant String := "day1_in";
  F : File_Type;

  function MaxCalories return Integer is
    Line : Bounded_String;
    Max, C : Integer := 0;
  begin
    Open (F, In_File, File_Name);

    while not End_Of_File (F) loop
      Line := To_Bounded_String (Get_Line (F));
      if To_String (Line) = "" then
        Max := (if Max > C then Max else C);
        C := 0;
      else 
        C := C + Integer'Value (To_String (Line));
      end if;
    end loop;

    Max := (if Max > C then Max else C);

    Close (F);
    return Max;
  end MaxCalories;

  function TopThreeCalories return Integer is
    Line : Bounded_String;
    Max1, Max2, Max3, C : Integer := 0;
  begin
    Open (F, In_File, File_Name);

    while not End_Of_File (F) loop
      Line := To_Bounded_String (Get_Line (F));
      if To_String (Line) = "" then
        if C > Max1 then
          Max3 := Max2;
          Max2 := Max1;
          Max1 := C;
        elsif C > Max2 then
          Max3 := Max2;
          Max2 := C;
        elsif C > Max3 then
          Max3 := C;
        end if;
        C := 0;
      else
        C := C + Integer'Value (To_String (Line));
      end if;
    end loop;

    if C > Max1 then
      Max3 := Max2;
      Max2 := Max1;
      Max1 := C;
    elsif C > Max2 then
      Max3 := Max2;
      Max2 := C;
    elsif C > Max3 then
      Max3 := C;
    end if;

    Close (F);
    return Max1 + Max2 + Max3;
  end TopThreeCalories;

begin

  Put_Line ("The elf with the most calories has" & MaxCalories'Image & " calories.");

  Put_Line ("The top three elves with the most calories has"
            & TopThreeCalories'Image & " calories.");

end Day1;
