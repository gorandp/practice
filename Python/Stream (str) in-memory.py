import io

output = io.StringIO()
output.write('First line.\n')

print(output.tell())

print('Second line.', file=output)
print(output.tell())

# Retrieve file contents -- this will be
# 'First line.\nSecond line.\n'
contents = output.getvalue()
print(contents)
# Close object and discard memory buffer --
# .getvalue() will now raise an exception.

print(output.seek(0,0))
num_of_char = output.readline
output.write('\b\b\b\b\b\b\b\b\b\b\b\b')
contents = output.getvalue()
print(contents)

output.close()
