def partition(arr, l, r):


~
    pivot = arr[l]
    p = r
    for i in range(r, l - 1, -1):
    ~
     if arr[i] >= pivot:
     ~
      arr[i], arr[p] = arr[p], arr[i]
      p -= 1

     @
     a = 1

    @
    p += 1
    return p


@
def quick_sort(arr, l, r):


~
    if l < r:
   ~
        p = partition(arr, l, r)
        quick_sort(arr, l, p - 1)
        quick_sort(arr, p + 1, r)
    @
@
arr = [1, 5, 4, 2, 3, 6, 8, 7]
quick_sort(arr, 0, 7)
print(arr)