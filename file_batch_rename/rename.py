#! /usr/bin/env python3
import os, sys, shutil

def

def moveFunc2(targetPath, rootPath = '.'):
    probe = False
    fileList = os.listdir(rootPath)
    for fileName in fileList:
        filePath = os.path.join(rootPath, fileName)
        if os.path.isdir(filePath):
            moveFunc2(targetPath, filePath)
        else:
            targetIsRoot = targetPath == rootPath
            if targetIsRoot:
                probe = True
                continue
            else:
                tmpTargetPath = os.path.join(targetPath, fileName)
                if os.path.exists(tmpTargetPath):
                    print('''\
                    The file: {0}
                    Path: {1}
                    It is exist in target path!
                    Target Path: {2}
                    '''.format(fileName, filePath, targetPath))
                    overwrite = input('overwrite?(Y/n): ')
                    if overwrite.lower() == 'y':
                        os.remove(tmpTargetPath)
                        shutil.move(filePath, targetPath)
                        print('Overwritten: ' + fileName)
                    else:
                        rename = input('rename and move?(Y/n): ')
                        if rename.lower() == 'y':
                            reFileName = input('rename: ')
                            reFilePath = os.path.join(rootPath, reFileName)
                            os.renames(filePath, reFilePath)
                            shutil.move(reFilePath, targetPath)
                            print('Renamed and Moved: ' + reFileName)
                        else:
                            exit()
                else:
                    shutil.move(filePath, targetPath)
                    print('Moved: ' + fileName)

    if not probe:
        os.rmdir(rootPath)
        print('Removed: ' + rootPath)

    return

def splitFileName(path):
    fileDict = {}
    trash = set()
    use = set()
    if os.path.isabs(path):
        path = os.path.abspath(path)
    for file in os.listdir(path):
        if os.path.isdir(file):
            continue
        else:
            tmp = os.path.splitext(file)
            exName = tmp[1]
            if (exName not in trash) and (exName not in use):
                judge = input('Extension name: {0}, ignore?(Enter to ignore / N): '.format(exName))
                if not judge:
                    trash.add(exName)
                    continue
                elif judge.lower() == 'n':
                    use.add(exName)
                    fileDict.setdefault(exName, set()).add(tmp[0])
            elif exName in use:
                fileDict.setdefault(exName, set()).add(tmp[0])

    use.clear()
    trash.clear()

    return fileDict

def renameSelectFile(dict, targetPath, no = 1):
    if no == 1:
        for exName, fileSet in dict.items():
            nameFormat = input('Input the new name format for extension {0}: '.format(exName))
            notSure = input('are you sure to rename format? Format: ' + nameFormat)
            if notSure:
                exit()
            else:
                formatPath = os.path.join(targetPath, nameFormat)
                fileList = list(fileSet)
                fileList.sort()
                for filePath in fileList:
                    newPath = formatPath + ('%02d' % (fileList.index(filePath)+1)) + exName
                    oldPath = os.path.join(targetPath, filePath + exName)
                    os.renames(oldPath, newPath)
                    print('Renamed: ' + newPath)

    return

workingPath = os.path.abspath(sys.argv[1])
targetPath = workingPath
isExist = os.path.exists(workingPath)

if not isExist:
    print('Error: the path is not exist!')
    exit()
else:
    print('The working path: ' + workingPath)
    tmpTargetPath = input('Input the target path: ')
    if tmpTargetPath == '':
        print('Are you sure to setting as the default working path?')
        sureAction = input('Enter (Y/n): ')
        if sureAction.lower() == 'y':
            print('The target path is: ' + targetPath)
        else:
            print('Error: setting the default path failed!')
            exit()
    elif os.path.exists(tmpTargetPath):
        targetPath = os.path.abspath(tmpTargetPath)
        print('The target path is: ' + targetPath)
    else:
        print('Error: target path is not exist!')
        exit()
    moveFlag = moveFunc2(targetPath, workingPath)
    print('Success: the files have been moved to the target directory!')
    selDict = splitFileName(targetPath)
    print('''\
    Select rename options:
    [1]: Positive sequence alignment
    ''')
    selNo = input('Select: ')
    renameSelectFile(selDict, targetPath, int(selNo))
