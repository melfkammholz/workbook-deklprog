#ifdef TEMPLATE
class Array:
    """Ein Array, das sich nie ändert: update gibt ein neues Array zurück."""

    @staticmethod
    def fromList(size, pairs):
        raise NotImplementedError

    def __getitem__(self, index):
        raise NotImplementedError

    def __len__(self):
        raise NotImplementedError

    def update(self, values):
        raise NotImplementedError
#else
class Array:
    def __init__(self, size, data):
        self.size = size
        self.data = data

    @staticmethod
    def fromList(size, pairs):
        data = [None] * size
        for index, value in pairs:
            data[index] = value
        return Array(size, data)

    def __getitem__(self, index):
        if not 0 <= index < self.size:
            raise IndexError("index out of bounds")
        return self.data[index]

    def __len__(self):
        return self.size

    def update(self, values):
        data = self.data.copy()
        for index, value in values:
            data[index] = value
        return Array(self.size, data)
#endif


# The example program from the task. In the interpreter: main()
def main():
    a = Array.fromList(5, [(2, 4), (3, 3)])

    b = a.update([(1, 3), (2, 2)])
    for i in range(len(a)):
        print(a[i], b[i])
