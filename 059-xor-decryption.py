def decrypt(cipher, password):
    chars = []
    for i, value in enumerate(cipher):
        key = ord(password[i % 3])
        chars.append(chr(value ^ key))
    return "".join(chars)


def solve(filename):
    with open(filename, "r") as fin:
        cipher = list(map(int, fin.read().split(",")))
        for x in range(ord("a"), ord("z") + 1):
            for y in range(ord("a"), ord("z") + 1):
                for z in range(ord("a"), ord("z") + 1):
                    password = "".join(map(chr, (x, y, z)))
                    decrypted = decrypt(cipher, password)
                    if " the " in decrypted:
                        print(f"Password: {password}")
                        print(f"Decrypted: {decrypted}")
                        print(f"Answer: {sum(map(ord, decrypted))}")
                        return


solve("059-cipher.txt")
