---
title: Accelerator Firmware Crash Course — VHDL for Software People
summary: A thirteen-module, simulation-first VHDL course for physicists who already write C++ or Python and now have to read and modify FPGA firmware.
faculty: Prof. Lawrence Lee
department: Physics & Astronomy, University of Tennessee, Knoxville
department_id: utk-physics-and-astronomy
audience: Graduate students, postdocs, and engineers entering accelerator or DAQ firmware work
use_case: Graduate training, curriculum development
tools:
  - VHDL-2008
  - GHDL
  - GTKWave
  - AMD/Xilinx Vivado
  - Claude
tags:
  - Teaching
  - Graduate training
  - FPGA
  - Instrumentation
image: /assets/images/accelerator-firmware-crash-course.svg
repository_url: https://github.com/lawrenceleejr/AcceleratorFirmwareCrashCourse
---

## What faculty used it for

Students arriving in accelerator control and particle-physics data acquisition groups are usually competent programmers who have never described hardware. They are handed existing FPGA firmware and asked to understand it, change it, and eventually design their own. This is a crash course originally made for a postdoc who needed to quickly come up to speed on a wide array of FPGA topics, with a very specific aim to understand the specific use cases in particle, nuclear, and accelerator physics.

The modules start with entities, signals, combinational logic, and clocks, then work through state machines, memory and FIFOs, clock domain crossing, serial links, and debugging. After the first few modules the ordering is flexible, so a student with a specific firmware block to understand can jump to what they need.

Every module ships real, runnable VHDL with self-checking testbenches. The examples are drawn from the students' own domain — discriminators, triggers, waveform digitizers — rather than generic textbook counters. The toolchain is simulation-first with GHDL and GTKWave, both free, so nobody needs an FPGA board or a Vivado license to start; synthesis with Vivado for 7-series and UltraScale parts comes later.

## Why it was useful

The usual alternative is apprenticeship: a student reads the group's firmware, guesses at the conventions, and picks up the hardware mindset by osmosis over a year or two. Writing the course down turns that into a couple of weeks of structured work with immediate feedback from a simulator, and it means the same explanation does not have to be given individually to each new student.

The material is deliberately written to explain *why* a design is the way it is rather than only how to reproduce it, and to name the places where software instincts actively mislead — assignment semantics, sequencing, and the assumption that anything happens one step at a time. Those are the misconceptions that cost new firmware developers the most time.

Claude was used to draft and structure the modules and testbenches from a human-designed curriculum outline; the pedagogical sequencing and the choice of physics-grounded examples were set first, by hand.

## Materials to adapt

- The [AcceleratorFirmwareCrashCourse repository](https://github.com/lawrenceleejr/AcceleratorFirmwareCrashCourse), containing the module text, VHDL sources, and testbenches.
- GHDL and GTKWave for the simulation-only path; Vivado only if you want to synthesize.
- To adapt the course to another group, replace the discriminator and digitizer examples with firmware blocks your students will actually touch — the module structure and the software-to-hardware framing carry over unchanged.
