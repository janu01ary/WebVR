<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Untact Gallery</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
<style>
@font-face {
	font-family: 'NEXON Lv1 Gothic OTF';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/NEXON Lv1 Gothic OTF.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

body {
	font-family: 'NEXON Lv1 Gothic OTF';
}

#blocker {
	position: absolute;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
}

#instructions {
	width: 100%;
	height: 90%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
	font-size: 14px;
	cursor: pointer;
}

.btn {
	display: block;
	float:right;
	width: 150px;
	height: 50px;
	line-height: 40px;
	border: 1px white solid;
	border-radius:5px;
	margin: 5px auto;
	 margin-right: 15px;
	background-color: black;
	text-align: center;
	font-size: 17px;
	cursor: pointer;
	color: white;
	transition: all 0.9s, color 0.2;
}

.btn:hover {
	box-shadow:200px 0 0 0 rgba(255,255,255,0.5) inset;
}

p {
	color: white;
}

</style>
</head>
<body>
	<script type="module">

			import * as THREE from '<c:url value='/resources/libs/three.module.js' />';
			import { GLTFLoader } from '<c:url value='/resources/libs/GLTFLoader.js' />';
			import { PointerLockControls } from '<c:url value='/resources/jsm/controls/PointerLockControls.js' />';

			var camera, scene, renderer, controls, mouse, SELECTED;

			const objects = [];

			let raycaster;
			let cameraDirection = new THREE.Vector3();

			// 카메라 이동 관련 변수들
			let moveForward = false;
			let moveBackward = false;
			let moveLeft = false;
			let moveRight = false;

			let prevTime = performance.now();
			const velocity = new THREE.Vector3();
			const direction = new THREE.Vector3();
			const vertex = new THREE.Vector3();
			const color = new THREE.Color();

			// mouse ober 시 사용
			let boxEdge;
			let boxWireframe;
			let tempObject;

			const s3_url = "https://webvrbucket.s3.ap-northeast-2.amazonaws.com/exhibition/${exhibition.id}/";

			init();
			animate();

			function init() {
				// scene, camera, light 등 선언하고 추가
				camera = new THREE.PerspectiveCamera( 50, window.innerWidth / window.innerHeight, 1, 1000 );
				camera.position.x = 90;
				camera.position.y = 30;
				camera.position.z = 60;
				camera.rotation.y = Math.PI / 2;
				camera.zoom = 1;

				scene = new THREE.Scene();
				scene.background = new THREE.Color( 0xffffff );
				scene.fog = new THREE.Fog( 0xffffff, 0, 750 );

				const light = new THREE.HemisphereLight( 0xeeeeff, 0x777788, 1 );
				scene.add( light );

				// PointerLockControls 선언
				controls = new PointerLockControls( camera, document.body );

				// html요소 가져오기
				const blocker = document.getElementById( 'blocker' );
				const instructions = document.getElementById( 'instructions' );

				// 처음 실행 + Esc로 일시정지 + 브라우저 바깥으로 벗어났을 때 띄우는 안내문 이벤트
				instructions.addEventListener( 'click', function () {
					controls.lock();
				} );

				// 안내문 클릭 시 사라졌다가, 아니면 다시 나타남
				controls.addEventListener( 'lock', function () {
					instructions.style.display = 'none';
					blocker.style.display = 'none';
					console.log("lock");
				} );
				controls.addEventListener( 'unlock', function () {
					blocker.style.display = 'block';
					instructions.style.display = '';
				} );

				scene.add( controls.getObject() );

				// 이동 이벤트
				const onKeyDown = function ( event ) {

					switch ( event.code ) {

						case 'ArrowUp':
						case 'KeyW':
							moveForward = true;
							break;

						case 'ArrowLeft':
						case 'KeyA':
							moveLeft = true;
							break;

						case 'ArrowDown':
						case 'KeyS':
							moveBackward = true;
							break;

						case 'ArrowRight':
						case 'KeyD':
							moveRight = true;
							break;

						case 'KeyF':
							console.log("keyffff");
							// onMouseClick();
							break;

					}

				};
				const onKeyUp = function ( event ) {

					switch ( event.code ) {

						case 'ArrowUp':
						case 'KeyW':
							moveForward = false;
							break;

						case 'ArrowLeft':
						case 'KeyA':
							moveLeft = false;
							break;

						case 'ArrowDown':
						case 'KeyS':
							moveBackward = false;
							break;

						case 'ArrowRight':
						case 'KeyD':
							moveRight = false;
							break;

					}

				};

				document.addEventListener( 'keydown', onKeyDown );
				document.addEventListener( 'keyup', onKeyUp );


				// raycaster + 그림 클릭 이벤트
				raycaster = new THREE.Raycaster();

				mouse = new THREE.Vector2();
				mouse.x = mouse.y = -1;

				let onMouseClick = function(e){
					if (instructions.style.display == 'none') {
						event.preventDefault();
						if ( SELECTED ){
							console.log("SELECTED : ", SELECTED);
							console.log("event: ", e);
							window.open("<c:url value='/WebVR/exhb/List/artwork?artworkId=' />" + SELECTED.uuid);
							controls.unlock();
						}
					} 
				}

				// renderer 관련 함수 + 윈도우 창 크기 조절 이벤트
				renderer = new THREE.WebGLRenderer( { antialias: true } );
				renderer.setPixelRatio( window.devicePixelRatio );
				renderer.setSize( window.innerWidth, window.innerHeight );
				document.body.appendChild( renderer.domElement );
   				
				document.addEventListener( 'click', onMouseClick );
				window.addEventListener( 'resize', onWindowResize );

				requestAnimationFrame(render);

				//GLTF (전시회장) 불러오기
				const loader2 = new GLTFLoader();
       		    loader2.load(
                	'<c:url value='/resources/three_js/exhibition_test.gltf' />',
                	function ( gltf ) {
                    	scene.add( gltf.scene );
                    	gltf.animations; 
                    	gltf.scene; 
                    	gltf.scenes; 
                    	gltf.cameras; 
                    	gltf.asset; 
                	}
            	);


				// 큐브에 작품 이미지 배치
				const img_loader = new THREE.TextureLoader();

				function Vector(x, y, z) {
					this.x = x;
					this.y = y;
					this.z = z;
				}

				// 파라미터 id: artwork의 id / imgUrl: artwork의 이미지 url / size: artwork의 크기(Vector) / position: artwork의 위치
				function makeImgCube(id, imgUrl, size, position) {
					const geometry = new THREE.BoxGeometry(size.x, size.y, size.z);
					img_loader.load(s3_url + imgUrl, (texture) => {
						const material = new THREE.MeshLambertMaterial({
							map: texture,
						});
						const cube = new THREE.Mesh(geometry, material);
						cube.position.x = position.x; // 가로로 이동
						cube.position.y = position.y; // 세로로 이동(높이 조정)
						cube.position.z = position.z; // 고정
						cube.uuid = id;
						scene.add(cube);
					});
				}

				// 작품의 위치 리스트
				const positionList = [
					new Vector(57, 30, 28),
					new Vector(-55, 30, 97),
					new Vector(0, 30, 97),
					new Vector(-97, 35, 40),
					new Vector(-59, 30, -22),
					new Vector(57, 30, 22),
					new Vector(97, 35, -40),
					new Vector(60, 30, -97),
					new Vector(0, 30, -97),
					new Vector(-60, 30, -97),
					new Vector(-97, 30, -62),
					new Vector(-57, 30, -28),
				];
					
				// 작품들을 모두 장면에 배치
				<c:forEach var="artwork" items="${artworkList}" varStatus="status">
					makeImgCube(
						"${artwork.artworkId}", 
						"${artwork.artworkAddress}", 
						<c:choose>
							<c:when test="${status.index eq 3 || status.index eq 6}"> 
								new Vector(1, ${artwork.height} / 20, ${artwork.width} / 20),
							</c:when>
							<c:when test="${status.index eq 10}"> 
								new Vector(1, ${artwork.height} / 30, ${artwork.width} / 30),
							</c:when>
							<c:otherwise>
								new Vector(${artwork.width} / 30, ${artwork.height} / 30, 1),
							</c:otherwise>
						</c:choose>
						positionList[${status.index}], 
					);
				</c:forEach>

				// spotlight를 만들어 장면에 배치
				function makeSpotLight(start, target) {
					const light = new THREE.SpotLight(0xffffff, 1);
					light.target.position.set(target.x, target.y, target.z);
					light.position.set(start.x, start.y, start.z);
					light.distance = 200;
					light.angle = 0.3;
					scene.add(light);
    				scene.add(light.target);
				}

				// spotlight 12개를 만들어 배치
				makeSpotLight(new Vector(57, 95, 58), positionList[0]); //0
				makeSpotLight(new Vector(-55, 95, 87), positionList[1]); //1
				makeSpotLight(new Vector(0, 95, 87), positionList[2]); //2
				makeSpotLight(new Vector(-67, 95, 40), positionList[3]); //3
				makeSpotLight(new Vector(-59, 95, 18), positionList[4]); //4
				makeSpotLight(new Vector(57, 95, -18), positionList[5]); //5
				makeSpotLight(new Vector(67, 95, -40), positionList[6]); //6
				makeSpotLight(new Vector(60, 95, -67), positionList[7]); //7
				makeSpotLight(new Vector(0, 95, -67), positionList[8]); //8
				makeSpotLight(new Vector(-55, 95, -67), positionList[9]); //9
				makeSpotLight(new Vector(-67, 95, -62), positionList[10]); //10
				makeSpotLight(new Vector(-57, 95, -58), positionList[11]); //11
	
			}

			function onWindowResize() {
				camera.aspect = window.innerWidth / window.innerHeight;
				camera.updateProjectionMatrix();
				renderer.setSize( window.innerWidth, window.innerHeight );
			}
			
			function resizeRendererToDisplaySize(renderer) {
				const canvas = renderer.domElement;
				const width = canvas.clientWidth;
				const height = canvas.clientHeight;
				const needResize = canvas.width !== width || canvas.height !== height;
				if (needResize) {
					renderer.setSize(width, height, false);
				}
				return needResize;
			}

			function animate() {

				requestAnimationFrame( animate );

				const time = performance.now();

				if ( controls.isLocked === true ) {

					raycaster.ray.origin.copy( controls.getObject().position );
					raycaster.ray.origin.y -= 10;

					const intersections = raycaster.intersectObjects( objects );

					const onObject = intersections.length > 0;

					const delta = ( time - prevTime ) / 1000;

					velocity.x -= velocity.x * 10.0 * delta;
					velocity.z -= velocity.z * 10.0 * delta;

					velocity.y -= 9.8 * 100.0 * delta; // 100.0 = mass

					direction.z = Number( moveForward ) - Number( moveBackward );
					direction.x = Number( moveRight ) - Number( moveLeft );
					direction.normalize(); // this ensures consistent movements in all directions

					if ( moveForward || moveBackward ) velocity.z -= direction.z * 400.0 * delta;
					if ( moveLeft || moveRight ) velocity.x -= direction.x * 400.0 * delta;

					if ( onObject === true ) {

						velocity.y = Math.max( 0, velocity.y );

					}

					controls.moveRight( - velocity.x * delta );
					controls.moveForward( - velocity.z * delta );

					controls.getObject().position.y += ( velocity.y * delta ); // new behavior

					if ( controls.getObject().position.y < 30 ) {
						velocity.y = 0;
						controls.getObject().position.y = 30;
					}

					// 벽이나 바닥 너머로 못 가게 함
					if ( controls.getObject().position.y < 30 ) {
						velocity.y = 0;
						controls.getObject().position.y = 30;
					}
					if ( controls.getObject().position.x < -92) {
						controls.getObject().position.x = -92;
					}
					if ( controls.getObject().position.x > 92 ) {
						controls.getObject().position.x = 92;
					}
					if ( controls.getObject().position.z < -92) {
						controls.getObject().position.z = -92;
					}
					if ( controls.getObject().position.z > 92 ) {
						controls.getObject().position.z = 92;
					}
					if ( controls.getObject().position.z < -92) {
						controls.getObject().position.z = -92;
					}
					if ( controls.getObject().position.z > 92 ) {
						controls.getObject().position.z = 92;
					}
					// 가벽 뚫고 못 가게 하기
					if ( controls.getObject().position.z < 36 && controls.getObject().position.z > 17 && controls.getObject().position.x > 12 ) {
						let dist1 = Math.abs(36 - controls.getObject().position.z);
						let dist2 = Math.abs(17 - controls.getObject().position.z)
						if(dist1 < dist2)
							controls.getObject().position.z = 36;
						else if(dist1 > dist2)
							controls.getObject().position.z = 17;
					} 
					if ( controls.getObject().position.z < -17 && controls.getObject().position.z > -36 && controls.getObject().position.x < -12 ) {
						let dist1 = Math.abs(-17 - controls.getObject().position.z);
						let dist2 = Math.abs(-36 - controls.getObject().position.z)
						if(dist1 < dist2)
							controls.getObject().position.z = -17;
						else if(dist1 > dist2)
							controls.getObject().position.z = -36;
					}

				}

				prevTime = time;

				// renderer.render( scene, camera );
			}

			function render(time) {
				time *= 0.001;

				if (resizeRendererToDisplaySize(renderer)) {
					const canvas = renderer.domElement;
					camera.aspect = canvas.clientWidth / canvas.clientHeight;
					camera.updateProjectionMatrix();
				}

				// raycaster가 카메라 방향을 바라보게 직진하도록 함
                raycaster.setFromCamera( camera.getWorldDirection( cameraDirection ), camera );

				// raycaster 확인용 arrow (사용할 떈 주석 풀기)
				//scene.add(new THREE.ArrowHelper(raycaster.ray.direction, raycaster.ray.origin, 300, 0xff0000) );

				let intersects = raycaster.intersectObjects(scene.children);
				// intersects.forEach(obj=>obj.object.material.color.set(0x00ff00));

				if ( intersects.length > 0 ) {
					// 마우스 over 시 큐브 따라 윤곽선 뜨게 하기
					if(intersects[0].object.getObjectByName("boxWireframe") == null){
						tempObject = intersects[0].object;
						boxEdge = new THREE.EdgesGeometry(intersects[0].object.geometry);
						
						if(intersects[0].object.rotation.y != 0)
							boxEdge.rotateY(Math.PI / 2);
						boxEdge.translate(intersects[0].object.position.x, intersects[0].object.position.y, intersects[0].object.position.z);
	
						boxWireframe = new THREE.LineSegments( boxEdge, new THREE.LineBasicMaterial({ color : 0xffee00, linewidth : 10 }));
						boxWireframe.renderOrder = 1;
						tempObject.attach( boxWireframe );
					}

					if ( SELECTED != intersects[ 0 ].object ) {
						// if ( SELECTED ) SELECTED.material.emissive.setHex( SELECTED.currentHex );
						SELECTED = intersects[ 0 ].object;
						//console.log("SELECTED : ", SELECTED);
						SELECTED.currentHex = SELECTED.material.emissive.getHex();
						// SELECTED.material.emissive.setHex( 0xff0000 );
						blocker.style.cursor = 'pointer';
					}
				} else {
					if(tempObject != null){
						tempObject.clear();
					}
					if ( SELECTED ) {
						// SELECTED.material.emissive.setHex( SELECTED.currentHex );
						SELECTED = null;
						blocker.style.cursor = 'auto';
					}
				}

				renderer.render(scene, camera);

				requestAnimationFrame(render); 
			}
		</script>
	<div id="blocker">
		<tr>
			<td width=70%><audio autoplay controls>
					<source src="https://webvrbucket.s3.ap-northeast-2.amazonaws.com/bgm/bensound-pianomoment.mp3"
						type="audio/mpeg" />
					Your browser does not support the audio tag.
				</audio></td>
			<td><a
				href="<c:url value='/WebVR/exhb/guestbook'>
                            <c:param name='exhibitionId' value='${exhibition.id}' />
                        </c:url>">
					<button type="button" class="btn">방명록</button>
			</a></td>
			<td><a
				href="<c:url value='/WebVR/exhb/List'>
                            <c:param name='exhibitionId' value='${exhibition.id}' />
                        </c:url>">
					<button type="button" class="btn">작품 모아 보기</button>
			</a></td>
		</tr>
		<div id="instructions">
			<p style="font-size: 36px">${exhibition.title}</p>
			<p style="font-size: 24px">${exhibition.description}</p>
			<p>
				Move: WASD<br /> Look: MOUSE<br /><br /><br /><br />
			</p>
		</div>
	</div>

</body>
</html>