with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Day8 is
  
  File_Name : constant String := "day8_in";
  F : File_Type;

  function Count_Rows return Natural is
    Rows : Natural := 0;
    Line : Unbounded_String;
  begin
    Open (F, In_File, File_Name);
    while not End_Of_File (F) loop
      Line := To_Unbounded_String (Get_Line (F));
      Rows := Rows + 1;
    end loop;
    Close (F);
    return Rows;
  end Count_Rows;

  function Count_Cols return Natural is
    Cols : Natural := 0;
    Line : Unbounded_String;
  begin
    Open (F, In_File, File_Name);
    if not End_Of_File (F) then
      Line := To_Unbounded_String (Get_Line (F));
      Cols := Length (Line);
    end if;
    Close (F);
    return Cols;
  end Count_Cols;

  Rows : constant Natural := Count_Rows;
  Cols : constant Natural := Count_Cols;

  type Tree_Grid is array (1 .. Cols, 1 .. Rows) of Natural;

  function Get_Trees return Tree_Grid is
    C : Character;
    Trees : Tree_Grid;
  begin
    Open (F, In_File, File_Name);
    for I in 1 .. Rows loop
      for J in 1 .. Cols loop
        Get (F, C);
        Trees (I, J) := Natural'Value ((1 => C));
      end loop;
    end loop;
    Close (F);
    return Trees;
  end Get_Trees;

  function Visible_Trees (Trees : Tree_Grid) return Natural is
    Visible : Tree_Grid := (others => (others => 0));
    Sum : Natural := 0;
    Prev1, Prev2 : Natural;
  begin
    Visible (1, 1) := 1;
    Visible (Rows, 1) := 1;
    Visible (1, Cols) := 1;
    Visible (Rows, Cols) := 1;

    for I in 2 .. Rows - 1 loop
      Prev1 := Trees (I, 1);
      Prev2 := Trees (I , Cols);
      Visible (I, 1) := 1;
      Visible (I, Cols) := 1;
      for J in 2 .. Cols - 1 loop
        if Trees (I, J) > Prev1 then
          Prev1 := Trees (I, J);
          Visible (I, J) := 1;
        end if;

        if Trees (I, Cols - J + 1) > Prev2 then
          Prev2 := Trees (I, Cols - J + 1);
          Visible (I, Cols - J + 1) := 1;
        end if;
      end loop;
    end loop;

    for J in 2 .. Cols - 1 loop
      Prev1 := Trees (1, J);
      Prev2 := Trees (Rows, J);
      Visible (1, J) := 1;
      Visible (Rows, J) := 1;
      for I in 2 .. Rows - 1 loop
        if Trees (I, J) > Prev1 then
          Prev1 := Trees (I, J);
          Visible (I, J) := 1;
        end if;
        if Trees (Rows - I + 1, J) > Prev2 then
          Prev2 := Trees (Rows - I + 1, J);
          Visible (Rows - I + 1, J) := 1;
        end if;
      end loop;
    end loop;

    for I in 1 .. Rows loop
      for J in 1 .. Cols loop
        Sum := Sum + Visible (I, J);
      end loop;
    end loop;

    return Sum;
  end Visible_Trees;

  function Best_Scenic_Score (Trees : Tree_Grid) return Natural is
    Best : Natural := 0;
    U, D, L, R, Score : Natural;
    Center : Natural;
  begin
    for I in 2 .. Rows - 1 loop
      for J in 2 .. Cols - 1 loop
        Center := Trees (I, J);
        
        U := 0;
        for T in 1 .. I - 1 loop
          U := U + 1;
          if Trees (I - T, J) >= Center then
            exit;
          end if;
        end loop;

        D := 0;
        for T in I + 1 .. Rows loop
          D := D + 1;
          if Trees (T, J) >= Center then
            exit;
          end if;
        end loop;

        L := 0;
        for T in 1 .. J - 1 loop
          L := L + 1;
          if Trees (I, J - T) >= Center then
            exit;
          end if;
        end loop;

        R := 0;
        for T in J + 1 .. Cols loop
          R := R + 1;
          if Trees (I, T) >= Center then
            exit;
          end if;
        end loop;

        Score := U * D * L * R;
        Best := (if Score > Best then Score else Best);

      end loop;
    end loop;
    return Best;
  end Best_Scenic_Score;

  Trees : Tree_Grid;

begin
  Trees := Get_Trees;

  Put_Line ("The number of visible trees is" & Visible_Trees(Trees)'Image);
  Put_Line ("The best scenic score in the trees is" &
            Best_Scenic_Score(Trees)'Image);

end Day8;
