
const fs = require('fs');

const data = fs.readFileSync('data.in', 'utf-8').split('\n');

console.log(data[data.length - 1]);

const createNode = (name, type, size, parent = null) => {
    
    return {
        __name: name,
        __type: type,
        __size: size,
        __parent: parent,
    };
}

const root = createNode('/', 'dir', 0, null);

let i = -1;
let ptr = root;


while(true) {
    i++;

    const line = data[i];
    if(line == '') {
        break;
    }

    const args = line.split(' ');

    if(args[0] == '$' && args[1] == 'cd') {
        if(args[2] == '..') {
            ptr = ptr.__parent;
            continue;
        }

        const dirname = args[2];

        if(!ptr[dirname]) {
            ptr[dirname] = createNode(dirname, 'dir', 0, ptr);
        }
        
        ptr = ptr[dirname];
    }

    if(args[0] == '$' && args[1] == 'ls') {
        while(true) {
            i++;
            const entry = data[i];

            if(entry == '' || entry[0] == '$') {
                i--;
                break;
            }

            const args = entry.split(' ');

            if(args[0] == 'dir') {
                const dirname = args[1];
                ptr[dirname] = createNode(dirname, 'dir', 0, ptr);
            }
            else {
                const filename = args[1];
                ptr[filename] = createNode(filename, 'file', +args[0], ptr);
            }
        }
    }
}

let acc = 0;

const updateCost = (ptr) => {
    if(ptr['__type'] == 'file') {
        return ptr['__size'];
    }
    
    let totalSize = 0;
    
    for(a in ptr) {
        if(a == '__name' || a == '__parent' || a == '__size' || a == '__type') {
            continue;
        }

        totalSize += updateCost(ptr[a]);
    }

    ptr['__size'] = totalSize;

    if(totalSize <= 100000) {
        acc += totalSize;
    }

    return totalSize;
}

let totalSpace = updateCost(root)

console.log(totalSpace);

console.log(acc);

const freeSpace = (70000000 - totalSpace)
const minimum = 30000000 - freeSpace;

acc = 70000000;
let name = 'not found';
const findMinimum = (ptr) => {
    const mySize = ptr['__size'];

    if(mySize < acc && mySize >= minimum) {
        acc = mySize;
        name = ptr['__name'];
    }

    
    for(a in ptr) {
        if(a == '__name' || a == '__parent' || a == '__size' || a == '__type') {
            continue;
        }

        findMinimum(ptr[a]);
    }

}

findMinimum(root);

console.log(minimum);
console.log(name);
console.log(acc);

