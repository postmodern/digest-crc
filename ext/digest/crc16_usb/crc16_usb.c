/**
 * \file
 * Functions and types for CRC checks.
 *
 * Generated on Sat Feb 29 02:05:41 2020
 * by pycrc v0.9.2, https://pycrc.org
 * using the configuration:
 *  - Width         = 16
 *  - Poly          = 0x8005
 *  - XorIn         = 0xffff
 *  - ReflectIn     = True
 *  - XorOut        = 0xffff
 *  - ReflectOut    = True
 *  - Algorithm     = table-driven
 */

#include "crc16_usb.h"
#include "crc16_usb_table.h"

crc16_t crc16_usb_update(crc16_t crc, const void *data, size_t data_len)
{
	const unsigned char *d = (const unsigned char *)data;
	unsigned int tbl_idx;

	for (; data_len >= SLICE_SIZE; data_len -= SLICE_SIZE)
	{
		crc = crc16_usb_table[15][d[ 0] ^ ((crc >>  0) & 0xff)] ^
		      crc16_usb_table[14][d[ 1] ^ ((crc >>  8) & 0xff)] ^
		      crc16_usb_table[13][d[ 2]                       ] ^
		      crc16_usb_table[12][d[ 3]                       ] ^
		      crc16_usb_table[11][d[ 4]                       ] ^
		      crc16_usb_table[10][d[ 5]                       ] ^
		      crc16_usb_table[ 9][d[ 6]                       ] ^
		      crc16_usb_table[ 8][d[ 7]                       ] ^
		      crc16_usb_table[ 7][d[ 8]                       ] ^
		      crc16_usb_table[ 6][d[ 9]                       ] ^
		      crc16_usb_table[ 5][d[10]                       ] ^
		      crc16_usb_table[ 4][d[11]                       ] ^
		      crc16_usb_table[ 3][d[12]                       ] ^
		      crc16_usb_table[ 2][d[13]                       ] ^
		      crc16_usb_table[ 1][d[14]                       ] ^
		      crc16_usb_table[ 0][d[15]                       ];
		crc &= 0xffff;
		d += SLICE_SIZE;
	}

	while (data_len--)
	{
		tbl_idx = (crc ^ *d) & 0xff;
		crc = (crc16_usb_table[0][tbl_idx] ^ (crc >> 8)) & 0xffff;
		d++;
	}

	return crc & 0xffff;
}
