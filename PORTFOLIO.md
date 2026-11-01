# Verilog Single-cycle CPU — 개인 RTL 구현 기록

> **이 문서는 Fork에 추가한 개인 구현을 설명합니다.** 기존 [yuxincs/MIPS-CPU](https://github.com/yuxincs/MIPS-CPU)의 Logisim 회로·자료를 본인이 처음 설계한 것으로 주장하지 않습니다.

## 프로젝트 개요

- **기간:** 2025년 5월
- **목표:** 기존 MIPS Logisim CPU 구조를 참고해 **32-bit Single-cycle CPU를 Verilog RTL로 재구현**하고 ModelSim에서 모듈별 동작을 살펴보기
- **개인 작업:** Verilog 모듈, 통합 datapath, CP0/예외 경로 시도, testbench/파형 관찰
- **소스:** [`modelsim/`](modelsim/) — Verilog RTL 및 ModelSim 테스트 관련 파일
- **이력서용 상세 근거:** [Verilog CPU 경험 문서](https://github.com/nanocode00/resume/blob/main/experiences/verilog-cpu.md)

## 구성

```text
InstructionMemory → Instruction decode / Control
                  → RegisterFile → ALU / Branch / Jump
                  → DataMemory → Writeback
                  ↘ CP0 / Exception control (미완성)
```

| 코드 | 내용 |
|---|---|
| [`SingleCycleCPU.v`](modelsim/SingleCycleCPU.v) | 전체 단일 사이클 datapath 연결 |
| [`ALU.v`](modelsim/ALU.v), [`RegisterFile.v`](modelsim/RegisterFile.v) | 산술 및 레지스터 처리 |
| [`Control.v`](modelsim/Control.v), [`Opcode_Decoder.v`](modelsim/Opcode_Decoder.v), [`Funct_Decoder.v`](modelsim/Funct_Decoder.v) | 명령 디코딩·제어 |
| [`InstructionMemory.v`](modelsim/InstructionMemory.v), [`DataMemory.v`](modelsim/DataMemory.v) | 명령·데이터 메모리 |
| [`CP0.v`](modelsim/CP0.v) | 외부 예외 입력·EPC/ERET 복귀 경로 시도 |
| [`tb_SingleCycleCPU.v`](modelsim/tb_SingleCycleCPU.v) 외 | 통합 및 단위별 테스트벤치 |
| [`wave_SingleCycleCPU.tcl`](modelsim/wave_SingleCycleCPU.tcl) 외 | ModelSim 파형 확인 설정 |

## 설계·검증에서 배운 점

1. 명령 디코더, ALU, 레지스터, 메모리를 분리해 구현한 다음 통합 `SingleCycleCPU`에서 연결했습니다.
2. 개별 모듈의 testbench와 ModelSim wave 설정을 작성해 입력/출력과 타이밍을 점검했습니다.
3. CP0/예외 경로에서는 외부 `ExpSrc`로 예외 진입과 `0x800` 벡터, EPC 저장 후 ERET 복귀를 의도했습니다.
4. **실제로는 예외 진입 시 EPC에 복귀 주소가 저장되지 않는 문제를 해결하지 못하고 종료**했습니다. 보존 RTL에서도 `eret` 디코딩 값과 TB 입력 명령의 불일치가 확인됩니다. 따라서 **예외 진입→EPC 저장→ERET 정상 복귀가 검증된 CPU라고 소개하지 않습니다.**

## 확인·재현 범위

`modelsim/`에 RTL `*.v`, `tb_*.v`, `wave_*.tcl`과 `SingleCycleCPU.mpf`가 있습니다. ModelSim에서 해당 프로젝트/테스트벤치를 열어 파형을 확인할 수 있도록 자료를 남겼으나, **현재 환경에서 클린 빌드와 전체 명령·예외 시나리오의 자동 검증을 재수행하지는 않았습니다.** 완성된 MIPS ISA 호환 프로세서나 타이밍·성능 측정 결과로 해석하지 마세요.

## 원본과 기여의 경계

- **원본:** [yuxincs/MIPS-CPU](https://github.com/yuxincs/MIPS-CPU) — Logisim MIPS CPU 회로와 테스트 프로그램. 이 Fork의 원본 README/라이선스를 유지합니다.
- **추가 구현:** [`modelsim/`](modelsim/)의 Verilog 재구현과 테스트 작업. [개발 이력과 실제 확인 한계](https://github.com/nanocode00/resume/blob/main/experiences/verilog-cpu-commit-ledger.md)를 분리해 공개합니다.
