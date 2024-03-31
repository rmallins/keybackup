# keybackup
Backup GPG private key files to paper hard-copy using QR codes. Restore later from a PDF/PNG/JPEG scan.

Provides a pair of commands to save and restore GPG key files to/from hard-copy to enable permanent backup in a safe (for example). This is useful because data on paper is likely to have a longer life than flash memory, and deterioration is visible and progressive rather than invisible and sudden. QR codes also provide strong error-correction capabilities which provides further robustness against deterioration.

| Command   | Purpose   |
|---  |---  |
| key2paper    | Take an ASCII armoured GPG key file as input, and output as <br>a collage of QR codes in PNG format for portrait printing to<br>a single A4 sheet of paper.  |
| paper2key    | Takes a scan of the printout from key2paper in PNG or JPEG<br>and reassembles them into the original file using the<br>original file name.    |

To ease filing the QR code collage includes a header specifying the
original filename and date of encoding.

## The process
### Backup
1. Export key file from GPG to ASCII armoured text file.
2. `key2paper <key file>` -> PNG collage of QR codes
3. Print the PNG to a single A4 sheet.

### Restore
1. Scan the A4 sheet to a PNG, JPEG or PDF (N.B. PDF requires special permissions in linux)
2. `paper2key <scan file>` -> copy of original key file.
3. Import the key file back into GPG.

# Dependencies
key2paper requires:
 * qrencode
 * montage (from imagemagick)

paper2key requires:
 * zbarimg

zbarimg is used to decode the QR code scan, and can take a variety of input formats. The code was originally tested with PNG and JPEG using a 4096bit RSA private key.

# Example usage:

Here a 4096 bit RSA key is translated into a PNG image and back to a key, with the sha1 hash showing that the data was faithfully reconstructed.

```
$ ls -l testkey_priv*
-rw-rw-r-- 1 rmallins rmallins 6756 Mar 31 00:52 testkey_priv.asc
-rw-rw-r-- 1 rmallins rmallins   59 Mar 31 00:52 testkey_priv.asc.sha1
$ shasum -c testkey_priv.asc.sha1
testkey_priv.asc: OK
$ ./key2paper testkey_priv.asc
Key testkey_priv.asc has been successfully encoded to testkey_priv.asc.png
$ ls -l testkey_priv.asc.png
-rw-rw-r-- 1 rmallins rmallins 39860 Mar 31 00:53 testkey_priv.asc.png
$ rm testkey_priv.asc
$ ./paper2key testkey_priv.asc.png
testkey_priv.asc has been successfully reconstructed from testkey_priv.asc.png
$ ls -l testkey_priv*
-rw-rw-r-- 1 rmallins rmallins  6756 Mar 31 00:54 testkey_priv.asc
-rw-rw-r-- 1 rmallins rmallins 39860 Mar 31 00:53 testkey_priv.asc.png
-rw-rw-r-- 1 rmallins rmallins    59 Mar 31 00:52 testkey_priv.asc.sha1
$ shasum -c testkey_priv.asc.sha1
testkey_priv.asc: OK
$
```
