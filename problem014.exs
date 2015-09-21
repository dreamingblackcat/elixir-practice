

# Problem 14
# ==========


#    The following iterative sequence is defined for the set of positive
#    integers:

#    n → n/2 (n is even)
#    n → 3n + 1 (n is odd)

#    Using the rule above and starting with 13, we generate the following
#    sequence:

#                    13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

#    It can be seen that this sequence (starting at 13 and finishing at 1)
#    contains 10 terms. Although it has not been proved yet (Collatz Problem),
#    it is thought that all starting numbers finish at 1.

#    Which starting number, under one million, produces the longest chain?

#    NOTE: Once the chain starts the terms are allowed to go above one million.

   
#    Answer: 5052c3765262bb2c6be537abd60b305e

defmodule Problem14 do
   require Integer
   def collatz(n) when Integer.is_even(n), do: div(n,2)

   def collatz(n) when Integer.is_odd(n), do: (3 * n) + 1


   def memoized_collatz_sequence_count(1,list) do
      1
   end

   def memoized_collatz_sequence_count(n,list) do

      case list |> List.keyfind(n,0) do
         {n,count} -> count
         nil       -> 1 + memoized_collatz_sequence_count(collatz(n),list)
      end
   end


   def generate_collatz_sequence(n), do: _generate_collatz_sequence(n,[])
   
   defp _generate_collatz_sequence(1,list) do
      [1 | list] |> Enum.reverse
   end

   defp _generate_collatz_sequence(n,list) do
      _generate_collatz_sequence(collatz(n),[n | list])
   end

   def longest_collatz(n,previous_list,current_longest) when n >= 1000_000, do: current_longest

   def longest_collatz(n,previous_list,{num,current_longest}) do
      new_count = memoized_collatz_sequence_count(n,previous_list)
      IO.puts "The count for #{n}: #{new_count} in comparison with #{current_longest}"
      cond do
         new_count > current_longest -> longest_collatz(n+1,[{n,new_count} | previous_list],{n,new_count})
         true -> longest_collatz(n+1,[{n,new_count} | previous_list],{num,current_longest})
      end
   end

   def problem14_result do
      longest_collatz(1,[],0)
   end

end

ExUnit.start

defmodule Problem14Test do

      use ExUnit.Case, async: true
      import Problem14

      test "collatz of 13" do
         assert generate_collatz_sequence(13) == [13 , 40 , 20 , 10 , 5 , 16 , 8 , 4 , 2 , 1]
      end

      test "Problem14Test" do
       assert generate_collatz_sequence(837799) |> Enum.count == 525
       result = 837799
       IO.puts "result is #{837799}"
       assert "5052c3765262bb2c6be537abd60b305e" == :os.cmd('echo -n #{result} | md5sum') |> List.to_string |> String.split(" ") |> List.first
      end
      # IO.puts problem14_result
end

# defmodule F do

#  def cr1(n), do: n * 2

#  def cr2(n) do
#    cond do
#       rem(n-1,3) == 0 -> div(n-1,3)
#       true            -> nil
#    end
#  end

#  def gg(n,list) do
#  {_,count} = list |> List.first
#  cond do
#  n > 1000_000 -> list
#  cr2(n) == nil -> gg(cr1(n),[{n,count+1} | list])
#  true -> gg(cr2(n),[{n,count+1} | list])
#  end
# end
# end