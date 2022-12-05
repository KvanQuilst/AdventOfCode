with Ada.Text_IO; use Ada.Text_IO;

procedure Day5 is
  package Int_IO is new Ada.Text_IO.Integer_IO (Integer);

  File_Name : constant String := "day5_in";
  F : File_Type;

  type Stack_Arr is array (1..48) of Character;
  type Crate_Stack is record
    Stack : Stack_Arr;
    Index : Integer := 0;
  end record;

  type Crate_Stacks is array (1..9) of Crate_Stack;

  procedure Push (Stack : in out Crate_Stack; Crate : Character) is
  begin
    Stack.Index := Stack.Index + 1;
    Stack.Stack (Stack.Index) := Crate;
  end Push;

  function Pop (Stack : in out Crate_Stack) return Character is
  begin
    Stack.Index := Stack.Index - 1;
    return Stack.Stack (Stack.Index + 1);
  end Pop;

  procedure Move_Multiple (Dest, Src : in out Crate_Stack; Num : Integer) is
  begin
    Src.Index := Src.Index - Num;
    for I in 1..Num loop
      Push (Dest, Src.Stack (Src.Index + I));
    end loop;
  end Move_Multiple;

  procedure Start_Stacks (Stacks : out Crate_Stacks) is

    function Get_Crate return Character is
      Crate, C : Character;
    begin
      Get (F, C);
      Get (F, Crate);
      Get (F, C);
      return Crate;
    end Get_Crate;

    C : Character;

  begin
    Open (F, In_File, File_Name);

    for I in 1..8 loop
      for J in Crate_Stacks'Range loop
        C := Get_Crate; 
        if C /= ' ' then
          Stacks (J).Stack (9 - I) := C;
          Stacks (J).Index := (if Stacks (J).Index = 0 then 9 - I else Stacks (J).Index);
        end if;
        if J /= 9 then
          Get (F, C);
        end if;
      end loop;
    end loop;

    Close (F);
  end Start_Stacks;

  type CrateMover is (CM9000, CM9001);
  function Crane_Instructions (Stacks : in out Crate_Stacks; 
                               CM : CrateMover) return String is
    Tops : String (Crate_Stacks'Range);
    Move : String (1..5);
    From : String (1..6);
    To : String (1..4);

    Num : Integer;
    Src : Integer;
    Dest : Integer; 

  begin
    Open (F, In_File, File_Name);
  
    loop
      if Get_Line (F) = "" then
        exit;
      end if;
    end loop;

    while not End_Of_File (F) loop
      Get (F, Move);
      Int_IO.Get (F, Num);
      Get (F, From);
      Int_IO.Get (F, Src);
      Get (F, To);
      Int_IO.Get (F, Dest);

      if CM = CM9000 then
        for I in 1..Num loop
          Push (Stacks (Dest), Pop (Stacks (Src)));
        end loop;
      elsif CM = CM9001 then
        Move_Multiple (Stacks (Dest), Stacks (Src), Num);
      end if;
    end loop;

    Close (F);

    for I in Crate_Stacks'Range loop
      Tops (I) := Stacks (I).Stack (Stacks (I).Index);
    end loop;
    
    return Tops;
  end Crane_Instructions;

  Stacks0, Stacks1 : Crate_Stacks;
    
begin
  Start_Stacks (Stacks0);
  Put_Line ("The tops of each stack after the crane instructions 9000 is " & 
            Crane_Instructions (Stacks0, CM9000));

  Start_Stacks (Stacks1);
  Put_Line ("The tops of each stack after the crane instructions 9001 is " & 
            Crane_Instructions (Stacks1, CM9001));

end Day5;
