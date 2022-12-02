with Ada.Text_IO; use Ada.Text_IO;

procedure Day2 is
  File_Name : constant String := "day2_in";
  F : File_Type;

  Line : String (1..3);
  Score1, Score2 : Integer := 0;

  type Opponent is (A, B, C);
  for Opponent use (A => 1, B => 2, C => 3);

  type Me is (X, Y, Z);
  for Me use (X => 1, Y => 2, Z => 3);

  function GetScore1 (O : Opponent; M : Me) return Integer is
  begin
    if Opponent'Enum_Rep (O) = Me'Enum_Rep (M) then return Me'Enum_Rep (M) + 3;
    elsif O = A and M = Y then return Me'Enum_Rep (M) + 6;
    elsif O = B and M = Z then return Me'Enum_Rep (M) + 6;
    elsif O = C and M = X then return Me'Enum_Rep (M) + 6;
    else return Me'Enum_Rep (M);
    end if;
  end GetScore1;

  function GetScore2 (O : Opponent; M : Me) return Integer is
  begin
    if M = X then
      case O is
        when A => return Opponent'Enum_Rep (C);
        when B => return Opponent'Enum_Rep (A);
        when C => return Opponent'Enum_Rep (B);
      end case;
    elsif M = Z then
      case O is
        when A => return Opponent'Enum_Rep (B) + 6;
        when B => return Opponent'Enum_Rep (C) + 6;
        when C => return Opponent'Enum_Rep (A) + 6;
      end case;
    else return Opponent'Enum_Rep (O) + 3;
    end if;
  end GetScore2;

begin

  Open (F, In_File, File_Name);

  while not End_Of_File (F) loop
    Line := Get_Line (F);    
    Score1 := Score1 + GetScore1 (Opponent'Value (Line (1..1)),
                                  Me'Value (Line (3..3)));
    Score2 := Score2 + GetScore2 (Opponent'Value (Line (1..1)),
                                  Me'Value (Line (3..3)));
  end loop;

  Close (F);

  Put_Line ("My Rock, Paper, Scissors 1st tournament score is" & Score1'Image);
  Put_Line ("My Rock, Paper, Scissors 2nd tournament score is" & Score2'Image);

end Day2;
