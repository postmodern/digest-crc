/**
 * \file
 * Functions and types for CRC checks.
 *
 * Generated on Sat Feb 29 02:33:28 2020
 * by pycrc v0.9.2, https://pycrc.org
 * using the configuration:
 *  - Width         = 64
 *  - Poly          = 0xad93d23594c935a9
 *  - XorIn         = 0xffffffffffffffff
 *  - ReflectIn     = True
 *  - XorOut        = 0x0000000000000000
 *  - ReflectOut    = True
 *  - Algorithm     = table-driven
 */

#include "crc64_jones.h"
#include "crc64_jones_table.h"

crc64_t crc64_jones_update(crc64_t crc, const void *data, size_t data_len)
{
	const unsigned char *d = (const unsigned char *)data;
	unsigned int tbl_idx;

	for (; data_len >= SLICE_SIZE; data_len -= SLICE_SIZE)
	{
		crc = crc64_jones_table[15][d[ 0] ^ ((crc >>  0) & 0xff)] ^
		      crc64_jones_table[14][d[ 1] ^ ((crc >>  8) & 0xff)] ^
		      crc64_jones_table[13][d[ 2] ^ ((crc >> 16) & 0xff)] ^
		      crc64_jones_table[12][d[ 3] ^ ((crc >> 24) & 0xff)] ^
		      crc64_jones_table[11][d[ 4] ^ ((crc >> 32) & 0xff)] ^
		      crc64_jones_table[10][d[ 5] ^ ((crc >> 40) & 0xff)] ^
		      crc64_jones_table[ 9][d[ 6] ^ ((crc >> 48) & 0xff)] ^
		      crc64_jones_table[ 8][d[ 7] ^ ((crc >> 56) & 0xff)] ^
		      crc64_jones_table[ 7][d[ 8]                       ] ^
		      crc64_jones_table[ 6][d[ 9]                       ] ^
		      crc64_jones_table[ 5][d[10]                       ] ^
		      crc64_jones_table[ 4][d[11]                       ] ^
		      crc64_jones_table[ 3][d[12]                       ] ^
		      crc64_jones_table[ 2][d[13]                       ] ^
		      crc64_jones_table[ 1][d[14]                       ] ^
		      crc64_jones_table[ 0][d[15]                       ];
		crc &= 0xffffffffffffffff;
		d += SLICE_SIZE;
	}

	while (data_len--)
	{
		tbl_idx = (crc ^ *d) & 0xff;
		crc = (crc64_jones_table[0][tbl_idx] ^ (crc >> 8)) & 0xffffffffffffffff;
		d++;
	}

	return crc & 0xffffffffffffffff;
}
