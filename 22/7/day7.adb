with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Day7 is
  package Int_IO is new Ada.Text_IO.Integer_IO (Natural);

  File_Name : constant String := "day7_in";
  F : File_Type;

  type Dir_Arr is array (1..16) of Natural;
  type Dir_Stack is record
    Idx : Positive := 1;
    Stack : Dir_Arr;
  end record;

  procedure Dir_Push (S : in out Dir_Stack; D : Natural) is
  begin
    S.Stack (S.Idx) := D;
    S.Idx := S.Idx + 1;
  end Dir_Push;

  function Dir_Pop (S : in out Dir_Stack) return Natural is
  begin
    S.Idx := S.Idx - 1;
    return S.Stack (S.Idx);
  end Dir_Pop;

  function Dir_Peek (S : in out Dir_Stack) return Natural is
  begin
    return S.Stack (S.Idx);
  end Dir_Peek;

  function Size_Under_100000 return Natural is  
    Sum : Natural := 0;
    DS : Dir_Stack;
    D : Natural;
    Sizing : Boolean := False;

    C : Character;
    EOF : Boolean;
    Size : Natural;
    Line : Unbounded_String;
  begin
    Open (F, In_File, File_Name);

    while not End_Of_File (F) loop
      case Sizing is
        when False =>
          Line := To_Unbounded_String (Get_Line (F));

          -- cd --
          if Slice (Line, 3, 4) = "cd" then

            if Slice (Line, 6, 6) = "." then
              D := Dir_Pop (DS);
              Sum := Sum + (if D <= 100000 then D else 0);
              -- Add the size of D to its parent --
              DS.Stack (DS.Idx-1) := DS.Stack (DS.Idx-1) + D;
            else
              Dir_Push (DS, 0);
            end if;

          -- ls --
          else
            Sizing := True;
          end if;

        when True =>
          Look_Ahead (F, C, EOF);
          
          -- End of ls --
          if C = '$' or EOF then
            Sizing := False;

          -- regular file --
          elsif C /= 'd' then
            Int_IO.Get (F, Size); 
            -- Add file size to current directory size --
            DS.Stack (DS.Idx-1) := DS.Stack (DS.Idx-1) + Size;
            Line := To_Unbounded_String (Get_Line (F));
          else
            Line := To_Unbounded_String (Get_Line (F));
          end if;
      end case;
    end loop;

    Close (F);

    -- Get directory sizes all the way back to '/' --
    while DS.Idx /= 1 loop
      D := Dir_Pop (DS);
      Sum := Sum + (if D <= 100000 then D else 0);
      if DS.Idx /= 1 then
        DS.Stack (DS.Idx-1) := DS.Stack (DS.Idx-1) + D;
      end if;
    end loop;

    return Sum;
  end Size_Under_100000;

  function Smallest_Delete return Natural is
    Sum : Natural := 0;
    Smallest : Natural := Natural'Last;
    DS : Dir_Stack;
    D : Natural;
    Sizing : Boolean := False;

    C : Character;
    EOF : Boolean;
    Size : Natural;
    Line : Unbounded_String;
  begin
    Open (F, In_File, File_Name);

    while not End_Of_File (F) loop
      Look_Ahead (F, C, EOF);
      if C /= '$' and C /= 'd' then
        Int_IO.Get (F, Size);
        Sum := Sum + Size;
      end if;
      Line := To_Unbounded_String (Get_Line (F));
    end loop;

    Reset (F);

    while not End_Of_File (F) loop
      case Sizing is
        when False =>
          Line := To_Unbounded_String (Get_Line (F));

          -- cd --
          if Slice (Line, 3, 4) = "cd" then

            if Slice (Line, 6, 6) = "." then
              D := Dir_Pop (DS);
              Smallest := (if D < Smallest and Sum - D <= 40000000
                           then D else Smallest);
              -- Add the size of D to its parent --
              DS.Stack (DS.Idx-1) := DS.Stack (DS.Idx-1) + D;
            else
              Dir_Push (DS, 0);
            end if;

          -- ls --
          else
            Sizing := True;
          end if;

        when True =>
          Look_Ahead (F, C, EOF);
          
          -- End of ls --
          if C = '$' or EOF then
            Sizing := False;

          -- regular file --
          elsif C /= 'd' then
            Int_IO.Get (F, Size); 
            -- Add file size to current directory size --
            DS.Stack (DS.Idx-1) := DS.Stack (DS.Idx-1) + Size;
            Line := To_Unbounded_String (Get_Line (F));
          else
            Line := To_Unbounded_String (Get_Line (F));
          end if;
      end case;
    end loop;

    Close (F);

    -- Get directory sizes all the way back to '/' --
    while DS.Idx /= 1 loop
      D := Dir_Pop (DS);
      Smallest := (if D < Smallest and Sum - D <= 4000000 
                   then D else Smallest);
      if DS.Idx /= 1 then
        DS.Stack (DS.Idx-1) := DS.Stack (DS.Idx-1) + D;
      end if;
    end loop;

    D := Sum - Smallest;

    return Smallest;
  end Smallest_Delete;

begin

  Put_Line ("The sum of the size of directories under 100000 is" &
            Size_Under_100000'Image);

  Put_Line ("The size of the smallest directory to delete for the update is" &
            Smallest_Delete'Image);

end Day7;
