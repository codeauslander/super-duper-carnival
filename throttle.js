// Some user interactions, such as resizing and scrolling, can create a huge number of browser events in a short period of time. If listeners attached to these events take a long time to execute, the user's browser can start to slow down significantly. To mitigate this issue, we want to to implement a throttle function that will detect clusters of events and reduce the number of times we call an expensive function. 

// Your function will accept an array representing a stream of event timestamps and return an array representing the times that a callback should have been called. If an event happens within wait time of the previous event, it is part of the same cluster. Your function should satisfy the following use cases: 

// 1) Firing once on the first event in a cluster, e.g. as soon as the window starts resizing. 
// 2) Firing once after the last event in a cluster, e.g. after the user window stops resizing. 
// 3) Firing every interval milliseconds during a cluster, e.g. every 100ms while the window is resizing.

const throttle = (wait, onLast, onFirst, interval, timestamps) => {
  let result = [];
  if (onFirst) {
    result.push(timestamps[0]);
  }
  if (interval > 0 && !onLast) {
    let n = 0;
    while (n < timestamps[timestamps.length - 2]) {
      result.push(n += interval);
    }
  } else if (interval > 0) {
    let n = 0;
    while (n < timestamps[timestamps.length - 1] + interval) {
      console.log(n + interval);
      result.push(n += interval);
    }
  } else if (onLast && onFirst) {
    let n = timestamps[1];
    while (n < timestamps[timestamps.length - 1]) {
      result.push(n += wait);
    }
  } else if (!onFirst) {
    for (let i = 1; i < timestamps.length; i++) {
      if (timestamps[i + 1] - timestamps[i] >= wait) {
        result.push(timestamps[i] += wait);
      }
    }
  }
  if (onLast) {
    result.push(timestamps[timestamps.length - 1] + wait);
  } else if (!onLast && timestamps[timestamps.length - 1] - timestamps[timestamps.length - 2] > wait) {
    result.push(timestamps[timestamps.length - 1]);
  }
  
  return result;
};

console.log(throttle(20, false, true, 0, [0,10,20,30]));
console.log(throttle(20, true, false, 0, [0,10,20,30]));
console.log(throttle(20, false, true, 20, [0,10,20,30]));
console.log(throttle(20, false, true, 0, [0,10,40]));
console.log(throttle(20, true, false, 0, [0,10,40]));
console.log(throttle(20, true, true, 0, [0,10,50]));
console.log(throttle(20, true, true, 10, [0,10,50]));

// Test Input Expected Result Result  Log
// 20, false, true, 0, [0,10,20,30] [0] - 
// 20, true, false, 0, [0,10,20,30] [50]  - 
// 20, false, true, 20, [0,10,20,30]  [0,20]  - 
// 20, false, true, 0, [0,10,40]  [0,40]  - 
// 20, true, false, 0, [0,10,40]  [30,60] - 
// 20, true, true, 0, [0,10,50] [0,30,50,70]  - 
// 20, true, true, 10, [0,10,50]  [0,10,20,30,50,60,70] - 