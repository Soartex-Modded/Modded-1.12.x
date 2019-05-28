import os
import zipfile


zip_file = zipfile.ZipFile('modded-1-12-2.zip', 'w', zipfile.ZIP_DEFLATED)

for root,dirs,files in os.walk('.'):
    relative_path = root[2:]
    if relative_path.count(os.sep) > 1:  # root ==  App/asserts/lowcase
        for f in files:
            zip_file.write(os.path.join(root, f), os.path.join(relative_path[relative_path.find(os.sep)+1:], f))

meta_filename = 'pack.mcmeta'
meta_content = '''
{
    "pack": {
        "pack_format": 3,
        "description": "Soartex-Modded 1.12.2 Textture Pack"
    }
}
'''

with open(meta_filename, 'w') as f:
    f.write(meta_content)

zip_file.write(meta_filename)
os.remove(meta_filename)
zip_file.close()
    
        
