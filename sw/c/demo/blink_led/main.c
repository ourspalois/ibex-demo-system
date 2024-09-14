#include <stdbool.h>

#include "demo_system.h"
#include "gpio.h"
#include "pwm.h"
#include "timer.h"

void main (void) {
  // Set the GPIO direction to output
  // The first argument is the GPIO port, the second is the value to write
  // to the direction register. 1 means output, 0 means input.
  set_outputs(GPIO_OUT, 0xFF); // Bottom 4 bits are LCD control as you can see in top_artya7.sv

}