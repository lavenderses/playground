from random import randint


def main():
    with open("attack.txt", "w") as f:
        for i in range(50 * 10):
            num = randint(1000, 9999)
            f.write("GET http://localhost:10001/{}\n".format(num))


if __name__ == "__main__":
    main()
