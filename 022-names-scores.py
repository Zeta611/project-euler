with open("022-names.txt", "r") as fin:
    names = sorted(name.strip('"') for name in fin.read().split(","))
    result = 0
    for i, name in enumerate(names):
        sum_ = 0
        for letter in name:
            sum_ += ord(letter) - ord("A") + 1
        result += sum_ * (i + 1)
    print(result)
