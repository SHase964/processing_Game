float floorHeight;
float x,y,vx,vy,ax,g;
float bgx,bgw;

void setup()
{
size(256,224);
background(0,95,191);
noStroke();

//床の高さを設定
floorHeight = 0.75*height;

x = 0;//○リオのx座標
y = floorHeight;//○リオのy座標
vx = 0;//○リオの横向きの速度
vy = 0;//○リオの縦向きの速度
ax = 0;//○リオの横向きの加速度
g = 1;//○リオの縦向きの加速度(重力加速度)

bgx = 0;//背景の位置
bgw = width * 2;//背景の幅
}

void draw()
{
background(0,95,191);

//●横方向の移動 
//横方向の速度に加速度を加える
vx += ax;
//加速しすぎたら速度を制限する
if(5<vx){
vx = 5;
}
if(vx<-5){
vx = -5;
}

//キーが押されていなければ減速していく
if(!keyPressed){
if(1<abs(vx)){
vx = 0.8*vx;
}else{
vx = 0;//速度の絶対値が1以下ならはしょって0に
}
}

//背景座標に応じて○リオを動かすか背景を動かすかする
if(bgx<=0){ //背景座標が0かそれ以下の時は○リオを動かす
x += vx;//○リオを動かす
if(width/2<x){//○リオが左側から真ん中に来たら背景を動かす
bgx += x-width/2;
x=width/2;
}
if(x<0){//○リオが左端に来たら外に出ないように調整
x = 0;
}
}else if(bgw<=bgx){//背景座標が背景の幅かそれ以上の時は○リオを動かす
x += vx;//○リオを動かす
if(x<width/2){//○リオが右側から真ん中に来たら背景を動かす
bgx -= width/2-x;
x=width/2;
}
if(width-16<x){//○リオが右端に来たら外に出ないように調整
x = width-16;
}
}else{//背景座標が0より大きく幅未満の時は背景を動かす
bgx += vx;//背景を動かす
if(bgx<0){//背景座標が0以下になったら○リオを動かす
x += bgx;
bgx = 0;
}
if(bgw<bgx){//背景座標が幅以上になったら○リオを動かす
x += bgx-bgw;
bgx = bgw;
}
}

//●縦方向の移動
vy += g;
y += vy;
if(floorHeight<y){//○リオが床より下に来たら外に出ないように調整
y = floorHeight;
}

//●背景を描画
drawBackground(bgx);

//●○リオ描画(ここでは赤い長方形)
fill(191,0,0);
rect(x,y-32,16,32);
}

//●キーが押された時の操作
void keyPressed()
{
switch(key){
case 'a'://左ボタンの代わり
if(0<vx){
ax = 1;//右に進んでいる時は減速
}else{
ax = -2;//左に進んでいる時はさらに加速
}
break;

case 'd'://右ボタンの代わり
if(vx<0){
ax = -1;//左に進んでいる時は減速
}else{
ax = 2;//右に進んでいる時はさらに加速
}
break;

case 'w'://上ボタンの代わり
//床の上にいる時だけ上向きに速度を与える
if(y == floorHeight){
vy = -10;
}
break;
}
}

//●キーが離された時の操作
void keyReleased()
{
//横向きの加速度を0にする
ax = 0;
}

//●背景座標をもとに描画する関数(draw()から呼び出される)
void drawBackground(float backgroundX)
{
  fill(0, 255, 0);
  rect(0,0-backgroundX,50, 50);
//背景にあるものを描画(ここでは白い丸)
fill(255);
ellipse(50-backgroundX,50,16,16);
ellipse(270-backgroundX,70,16,16);
ellipse(320-backgroundX,50,16,16);
ellipse(530-backgroundX,60,16,16);

//床描画
fill(95,0,0);
rect(0,floorHeight,width,50);
}
