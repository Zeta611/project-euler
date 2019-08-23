def decrypt(cipher, password):
    for i in range(len(cipher)):
        value = cipher[i]
        key = ord(password[i % 3])
        cipher[i] = chr(value ^ key)
    return "".join(cipher)


def solve(filename):
    with open(filename, "r") as file:
        cipher = list(map(int, file.read().split(",")))
        for x in range(ord("a"), ord("z") + 1):
            for y in range(ord("a"), ord("z") + 1):
                for z in range(ord("a"), ord("z") + 1):
                    password = "".join(map(chr, [x, y, z]))
                    decrypted = decrypt(cipher[:], password)
                    if " the " in decrypted:
                        print(f"password: {password}")
                        print(f"decrypted: {decrypted}")
                        print(f"answer: {sum(map(ord, decrypted))}")
                        return


solve("059-cipher.txt")
