# Problem 10
# ==========


#    The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

#    Find the sum of all the primes below two million.

   
#    Answer: d915b2a9ac8749a6b837404815f1ae25

defmodule Problem10 do

	def prime_test?(tuple) do
		{n,list} = tuple
		cond do
			list == []            -> true         
			rem(n, hd(list)) == 0 -> false
			hd(list) * 2 > n      -> true    
			true                  -> prime_test?({n, tl(list)})
		end
	end

	def next_prime_list(done,last,target) do
		current_is_prime = prime_test?({last,done})
		cond do
			last >= target -> done
			current_is_prime -> next_prime_list(done ++ [last],last+2,target)

			!current_is_prime -> next_prime_list(done,last+2,target)
		end
	end

	def sum_of_primes_under(3), do: 2

	def sum_of_primes_under(n) when n < 2, do: 0

	def sum_of_primes_under(n) do
		next_prime_list([2],3,n) |> Enum.sum
	end


	def problem10_result do
		sum_of_primes_under(2_000_000)
	end
end

ExUnit.start

defmodule Problem10Test do

   use ExUnit.Case, async: true
   import Problem10

   test "given primes under 10" do
   		assert sum_of_primes_under(10) == 17
   end

   # test "Problem9Test" do
   #  result = problem10_result
   #  assert "d915b2a9ac8749a6b837404815f1ae25" == :os.cmd('echo -n #{result |> Integer.to_string } | md5sum') |> List.to_string |> String.split(" ") |> List.first
   #  IO.puts "result is #{result}"
   # end
    IO.puts "result is #{problem10_result}" # ans = 142913828922

end