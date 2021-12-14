/*
    DMX Controller v2.0 beta - prepare.cpp
    Copyright (C) 2021 S.Pauthner

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#include <Arduino.h>
#include <EEPROM.h>

/*
 * This program will just update the EEPROM values for addresses 600, 601, 602, 603 and 610.
 * From these addresses the main program will read its starting modus.
 * After this program run the main program will start in manual modus
 */

void setup(){   // The function that will run only once
    for (uint8_t i = 0; i<4; i++){
        EEPROM.update(600 + i, 0);      // Update the EEPROM values
    }
    EEPROM.update(610, 1);
}

void loop(){    // The function that will run forever
    delay(100); // Do nothing
}
