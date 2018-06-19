

let result = (last,next,index) => {
  next = next * index
  return last - next
}

array = [7]

let first = array[0]
let next = 2
let index = 1
for (var i = 100 - 1; i >= 0; i--) {
  index = index * -1
  result = first + (next * index)
  array.push(result);
  first = result
  next = next + 1

}
console.log(array);


