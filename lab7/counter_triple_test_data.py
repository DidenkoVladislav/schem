def main():
    start = 45
    stop = 275

    with open("test_counter_triple.txt", "w") as f:
        f.write(f"1_0_1_{start:012b}_0")
        f.write(f"\n0_0_1_{start:012b}_0")

        for i in range(start + 1, stop):
            f.write(f"\n1_0_0_{i:012b}_0")
            f.write(f"\n0_0_0_{i:012b}_0")
        
        f.write(f"\n1_0_0_{stop:012b}_1")
        f.write(f"\n0_0_0_{stop:012b}_1")

        f.write(f"\n1_0_0_{stop:012b}_1")
        f.write(f"\n0_0_0_{stop:012b}_1")


if __name__ == "__main__":
    main()
