with Ada.Text_IO; use Ada.Text_IO;

procedure Day9 is 
  package Int_IO is new Ada.Text_IO.Integer_IO (Integer);

  File_Name : constant String := "day9_in";
  F : File_Type;

  function Num_Positions return Natural is
    Steps : Positive;
    C : Character;
    A, T : array (1 .. 2) of Integer := (0, 0);

    Contains : Boolean;
    Prev : array (1 .. 10000, 1 .. 2) of Integer;
    Idx : Natural := 0;
  begin
    Open (F, In_File, File_Name);

    while not End_Of_File (F) loop
      Get (F, C);      
      Int_IO.Get (F, Steps);

      for I in 1 .. Steps loop
        case C is
          when 'U' => A (2) := A (2) + 1;
          when 'D' => A (2) := A (2) - 1;
          when 'L' => A (1) := A (1) - 1;
          when 'R' => A (1) := A (1) + 1;
          when others => return 0;
        end case;

        if abs (A (1) - T (1)) > 1 or abs (A (2) - T (2)) > 1 then
          if T (1) /= A (1) then
            T (1) := T (1) + (if A (1) > T (1) then 1 else -1);
          end if;

          if T (2) /= A (2) then 
            T (2) := T (2) + (if A (2) > T (2) then 1 else -1);
          end if;
        end if;

        if Idx = 0 then
          Idx := Idx + 1;
          Prev (Idx, 1) := T (1);
          Prev (Idx, 2) := T (2);
        else
          Contains := False;
          for I in 1 .. Idx loop
            if Prev (I, 1) = T (1) and Prev (I, 2) = T (2) then
              Contains := True;
              exit;
            end if;
          end loop;

          if not Contains then
            Idx := Idx + 1;
            Prev (Idx, 1) := T (1);
            Prev (Idx, 2) := T (2);
          end if;
        end if;
      end loop;
    end loop;

    Close (F);
    return Idx;
  end Num_Positions;
  
  function Num_Positions10 return Natural is
    Steps : Positive;
    C : Character;

    K : array (0 .. 9, 1 .. 2) of Integer := (others => (others => 0));

    Contains : Boolean;
    Prev : array (1 .. 3000, 1 .. 2) of Integer;
    Idx : Positive := 0;
  begin
    Open (F, In_File, File_Name);

    while not End_Of_File (F) loop
      Get (F, C);      
      Int_IO.Get (F, Steps);

      for I in 1 .. Steps loop
        case C is
          when 'U' => K (0, 2) := K (0, 2) + 1;
          when 'D' => K (0, 2) := K (0, 2) - 1;
          when 'L' => K (0, 1) := K (0, 1) - 1;
          when 'R' => K (0, 1) := K (0, 1) + 1;
          when others => return 0;
        end case;

        for J in 1 .. 9 loop
          if abs (K (J - 1, 1) - K (J, 1)) > 1 or abs (K (J - 1, 2) - K (J, 2)) > 1 then
            if K (J, 1) /= K (J - 1, 1) then
              K (J, 1) := K (J, 1) + (if K (J - 1, 1) > K (J, 1) then 1 else -1);
            end if;

            if K (J, 2) /= K (J - 1, 2) then 
              K (J, 2) := K (J, 2) + (if K (J - 1, 2) > K (J, 2) then 1 else -1);
            end if;
          end if;
        end loop;

        if Idx = 0 then
          Idx := Idx + 1;
          Prev (Idx, 1) := K (9, 1);
          Prev (Idx, 2) := K (9, 2);
        else
          Contains := False;
          for I in 1 .. Idx loop
            if Prev (I, 1) = K (9, 1) and Prev (I, 2) = K (9, 2) then
              Contains := True;
              exit;
            end if;
          end loop;

          if not Contains then
            Idx := Idx + 1;
            Prev (Idx, 1) := K (9, 1);
            Prev (Idx, 2) := K (9, 2);
          end if;
        end if;
      end loop;
    end loop;

    Close (F);
    return Idx;
  end Num_Positions10;

begin

  Put_Line ("The number of positions that T visits is" & Num_Positions'Image);

  Put_Line ("The number of positions that the tail of 10 knots visits is" 
            & Num_Positions10'Image);

end Day9;
