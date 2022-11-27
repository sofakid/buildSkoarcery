import os
import subprocess

git_hash_cmd = ['git', 'rev-parse', '--short', 'HEAD']

Skoarcery_file = 'Skoarcery_commit'
Editoar_file = 'Editoar_commit'
android_file  = 'androidVersionCode'
juce_file  = 'juce_version'

git_fetch = ['git', 'fetch', 'origin']
git_get_latest_versions = ['git', 'checkout', '-f', 'origin/master', android_file]
print('Updating versions')

os.chdir('version')

# --- get latest android version
with subprocess.Popen(git_fetch, stdout=subprocess.PIPE) as proc:
  print(proc.stdout.readline().decode('utf-8'))

with subprocess.Popen(git_get_latest_versions, stdout=subprocess.PIPE) as proc:
  print(proc.stdout.readline().decode('utf-8'))

# read files

with open(Skoarcery_file, 'r') as fd:
  old_Skoarcery_commit = fd.readline()

with open(Editoar_file, 'r') as fd:
  old_Editoar_commit = fd.readline()

with open(android_file, 'r') as fd:
  old_android_code = int(fd.readline())

with open(juce_file, 'r') as fd:
  old_juce_version = fd.readline()

# get new versions

os.chdir('../p/Skoarcery')
with subprocess.Popen(git_hash_cmd, stdout=subprocess.PIPE) as proc:
  new_Skoarcery_commit = str(proc.stdout.readline().decode('utf-8').strip())

os.chdir('../Editoar')
with subprocess.Popen(git_hash_cmd, stdout=subprocess.PIPE) as proc:
  new_Editoar_commit = str(proc.stdout.readline().decode('utf-8').strip())

new_juce_version = os.environ['JUCE_TAG'].replace('"', '')


# write files

os.chdir('../../version')

with open(Skoarcery_file, 'w') as text_file:
  text_file.write(new_Skoarcery_commit)

with open(Editoar_file, 'w') as text_file:
  text_file.write(new_Editoar_commit)

with open(juce_file, 'w') as text_file:
  text_file.write(new_juce_version)

if (new_Skoarcery_commit != old_Skoarcery_commit or 
  new_Editoar_commit != old_Editoar_commit or 
  new_juce_version != old_juce_version):
    new_android_code = old_android_code + 1
    with open(android_file, 'w') as text_file:
      text_file.write('%s' % new_android_code)
else:
  print('Nothings changed, not incrementing Android build code.')
  new_android_code = old_android_code

os.system('git add --all .')
os.system('git commit -m "new version"')
os.system('git push origin master')

print('------------------------------------------------------------------------------------------------')
print('Versioner:     Skoarcery: ' + old_Skoarcery_commit + ' --> ' + new_Skoarcery_commit)
print('Versioner:       Editoar: ' + old_Editoar_commit + ' --> ' + new_Editoar_commit)
print('Versioner:          JUCE: ' + old_juce_version + ' --> ' + new_juce_version)
print('Versioner: Android build: ' + str(old_android_code) + ' --> ' + str(new_android_code))
print('------------------------------------------------------------------------------------------------')

blurp = """
version_cpp = 'p/Editoar/Editoar/Source/Version.cpp'
os.chdir('..')

version_cpp_code = '''
#include "Version.h"

const String Version::getVersion ()
{
    return String (TRANS("v1.")) + getAndroidVersionCode ();
}

const String Version::getAndroidVersionCode ()
{
    return String (TRANS ("''' + str(new_android_code) + '''"));
}

const String Version::getSkoarceryHash ()
{
    return String (TRANS ("''' + new_Skoarcery_commit + '''"));
}

const String Version::getEditoarHash ()
{
    return String (TRANS ("''' + new_Editoar_commit + '''"));
}

const String Version::getJuce ()
{
    return String (TRANS ("''' + new_juce_version + '''"));
}

'''

with open(version_cpp, 'w') as fd:
  fd.write(version_cpp_code)

print('Wrote ' + version_cpp + ':\n')
print(version_cpp_code)
"""