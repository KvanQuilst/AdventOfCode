with Ada.Text_IO; use Ada.Text_IO;

procedure Day10 is
  package Int_IO is new Ada.Text_IO.Integer_IO (Integer);

  File_Name : constant String := "day10_in";
  F : File_Type;

  function Signal_Strength return Natural is
    Instr : String (1 .. 4);
    Cycle : Natural := 0;
    X : Integer := 1;
    Op : Integer;
    Sum : Natural := 0;
  begin
    Open (F, In_File, File_Name);

    while not End_Of_File (F) loop
      Get (F, Instr);

      if Instr = "noop" then
        Cycle := Cycle + 1;
        if Cycle = 20 or Cycle = 60 or Cycle = 100 or
           Cycle = 140 or Cycle = 180 or Cycle =  220 then
          Sum := Sum + Cycle * X;
        end if;
      elsif Instr = "addx" then
        Int_IO.Get (F, Op);
        for I in 1 .. 2 loop
          Cycle := Cycle + 1;
          if Cycle = 20 or Cycle = 60 or Cycle = 100 or
             Cycle = 140 or Cycle = 180 or Cycle =  220 then
            Sum := Sum + Cycle * X;
          end if;
        end loop;
        X := X + Op;
      end if;
    end loop;

    Close (F);
    return Sum;
  end Signal_Strength;

  procedure Render_Sprite is
    Instr : String (1 .. 4);
    Cycle : Natural := 0;
    X : Integer := 1;
    Op : Integer;
    Pos : Integer;
    Line : Natural := 1;
  begin
    Open (F, In_File, File_Name);

    while not End_Of_File (F) loop
      Get (F, Instr);

      if Instr = "noop" then
        Cycle := Cycle + 1;
        Pos := Cycle mod 40;
        if Pos = X - 1 or Pos = X or Pos = X + 1 then
          Put ("#");
        else
          Put (".");
        end if;
        if Cycle mod 40 = 0 then
          Put_Line ("");
          Line := Line + 1;
        end if;

        if Line = 7 then
          exit;
        end if;

      elsif Instr = "addx" then
        Int_IO.Get (F, Op);
        for I in 1 .. 2 loop
          Cycle := Cycle + 1;
          Pos := Cycle mod 40;
          if Pos = X - 1 or Pos = X or Pos = X + 1 then
            Put ("#");
          else
            Put (".");
          end if;
          if Cycle mod 40 = 0 then
            Put_Line ("");
            Line := Line + 1;
          end if;

          if Line = 7 then
            exit;
          end if;
        end loop;
        X := X + Op;
      end if;
    end loop;
    Close (F);
  end Render_Sprite;

begin

  Put_Line ("" & Signal_Strength'Image);
  Render_Sprite;

end Day10;
