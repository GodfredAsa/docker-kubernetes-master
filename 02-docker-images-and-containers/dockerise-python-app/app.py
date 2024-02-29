min_num = int(input("Enter a minimum number: "))
max_num = int(input("Enter a maximum number: "))

if(min_num > max_num):
    print("Invalid minimum number")
else:
    result = max_num - min_num
    print(f"Difference: {result}")
