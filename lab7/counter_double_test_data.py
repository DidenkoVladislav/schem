def main():
    start = 45
    stop = 275

    with open("test_counter_double.txt", "w") as f:
        f.write(f"1_1_0_{0:09b}_0")
        f.write(f"\n0_0_0_{0:09b}_0")

        f.write(f"\n1_0_1_{start:09b}_0")
        f.write(f"\n0_0_1_{start:09b}_0")

        for i in range(start + 1, stop):
            f.write(f"\n1_0_0_{i:09b}_0")
            f.write(f"\n0_0_0_{i:09b}_0")
        
        f.write(f"\n1_0_0_{stop:09b}_1")
        f.write(f"\n0_0_0_{stop:09b}_1")

        f.write(f"\n1_0_0_{stop:09b}_1")
        f.write(f"\n0_0_0_{stop:09b}_1")


if __name__ == "__main__":
    main()
